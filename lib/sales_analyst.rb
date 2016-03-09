require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
  include AnalystAssistant
  attr_reader :se, :merch_ids

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (items.all.size.to_f / all_merchants.size).round(2)
  end

  def average_items_per_merchant_standard_deviation
    num = find_merchant_ids.map do |id|
      items_by_merch_id(id).size
    end.map do |item_number|
      (item_number - average_items_per_merchant) ** 2
    end.reduce(:+) / (all_merchants.size - 1)
    Math.sqrt(num).round(2)
  end

  def find_merchant_ids
    all_merchants.map do |merch|
      merch.id
    end
  end

  def merchants_with_high_item_count
    baseline = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    find_merchant_ids.find_all do |id|
      id if items_by_merch_id(id).size > baseline
    end.map do |id|
      merchants.find_by_id(id)
    end
  end

  def average_item_price_for_merchant(id)
    prices = items_by_merch_id(id).map do |item|
      item.unit_price
    end
    (prices.reduce(:+)/prices.size).round(2)
  end

  def average_average_price_per_merchant
    prices = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (prices.reduce(:+)/prices.length).round(2)
  end

  def golden_items
    all_items = items.all.map { |item| item.unit_price }
    ave = all_items.reduce(:+) / all_items.size
    sum_of_diffs = all_items.map { |price| (price - ave)**2 }.reduce(:+)
    sd = Math.sqrt(sum_of_diffs/ (all_items.size - 1))
    base = all_items.reduce(:+) / all_items.size + (sd*2)
    range = (base..BigDecimal::INFINITY)
    items.find_all_by_price_in_range(range)
  end

  def average_invoices_per_merchant_standard_deviation
    ave = average_invoices_per_merchant
    Math.sqrt(all_merchants.map do |merchant|
      (merchant.invoices.size.to_f - ave)**2
    end.reduce(:+) / (all_merchants.size - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    baseline = (average_invoices_per_merchant +
                average_invoices_per_merchant_standard_deviation * 2)
    all_merchants.find_all do |merchant|
      merchant.invoices.size > baseline
    end
  end

  def bottom_merchants_by_invoice_count
    baseline = (average_invoices_per_merchant -
                average_invoices_per_merchant_standard_deviation *  2)
    all_merchants.find_all do |merchant|
      merchant.invoices.size < baseline
    end
  end

  def top_days_by_invoice_count
    daily = Hash.new(0)

    all_merchants.map do |merchant|
      merchant.invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
    end.flatten.each{ |weekday| daily[weekday]+=1 }

    sum_of_squares = daily.values.map do |count|
      (count - (invoices.all.size / 7.0))**2
    end.reduce(:+)/6
    baseline = (invoices.all.size / 7.0) + Math.sqrt(sum_of_squares).round(2)
    daily.reject do |day, count|
      day if count < baseline
    end.keys
  end

  def invoice_status(status)
    total = invoices.all.size.to_f
    total_w_status = invoices.find_all_by_status(status).size
    ((total_w_status / total)*100).round(2)
  end

  def total_revenue_by_date(date)
    ids = invoices.find_all_by_date(date).map { |invoice| invoice.id }
    iis = ids.map{ |id| @se.invoice_items.find_all_by_invoice_id(id) }.flatten
    iis.map do |ii|
      ii.quantity * ii.unit_price
    end.reduce(:+)
  end

  def revenue_by_merchant(id)
    invoices = invoices.all.find_all{|invoice| invoice.merchant_id == id}
    #returns the invoices associated with the merchant
    totals = invoices.map do |invoice|
      if invoice.is_paid_in_full?
        invoice.total
      else
        BigDecimal.new(0)
      end
    end
    totals.reduce(:+)
  end

  def top_revenue_earners(n = 20)
    merchants_ranked_by_revenue[0..(n-1)]
  end

  def merchants_ranked_by_revenue
    ids = all_merchants.map{ |merchant| merchant.id }
    zipped = ids.map{|id| revenue_by_merchant(id) }.zip(ids.map{|id| merchants.find_by_id(id) })
    zipped.map do |pairs|
      pairs.map.with_index{ |pair, index| pairs[index] = BigDecimal.new(0) if pair == nil }
    end
    ranked = zipped.sort_by{|pair| pair[0] }.reverse
    ranked.map{ |pair| pair[1] }
  end

  def merchants_with_pending_invoices
    invoices.all.reject do |invoice|
      !invoice.all_failed_transactions?
    end.map do |invoice|
      invoice.merchant_id
    end.uniq.map do |id|
      merchants.find_by_id(id)
    end
  end

  def merchants_with_only_one_item
    all_merchants.find_all{|merchant| merchant.items.size == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_registered_in_month = all_merchants.find_all do |merchant|
      Date::MONTHNAMES[merchant.created_at.month] == month_name
    end
    all_items = merchants_registered_in_month.map do |merchant|
      merchant.items
    end
    ones = all_items.keep_if{|items| items.size == 1 }.flatten
    ids = ones.map{|item| item.merchant_id }
    ids.map{|id| merchants.find_by_id(id) }
  end

  def first_half(merchant_id)
    invoices = invoices.find_all_by_merchant_id(merchant_id).map do |invoice|
      invoice
    end
    successful = invoices.reject do |invoice|
      invoice.all_failed_transactions?
    end
    invoice_numbers = successful.map do |invoice|
      invoice.id
    end
    @ii_objects = invoice_numbers.map do |num|
      @se.invoice_items.find_all_by_invoice_id(num)
    end.flatten
  end

  def most_sold_item_for_merchant(merchant_id)
    first_half(merchant_id)
    sorted = @ii_objects.sort_by { |ii| ii.quantity }.reverse
    winners = sorted.reject{|invoice_item| invoice_item.quantity < sorted.first.quantity }
    ids = winners.map{|invoice_item| invoice_item.item_id }
    ids.map{|id| items.find_by_id(id)}.uniq
  end

  def best_item_for_merchant(merchant_id)
    first_half(merchant_id)
    a = @ii_objects.map do |obj|
      [(obj.unit_price * obj.quantity), obj.item_id]
    end.sort.last[-1]
    items.find_by_id(a)
  end

end
