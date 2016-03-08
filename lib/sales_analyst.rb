require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
  attr_reader :se, :merch_ids

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.all.size.to_f / @se.merchants.all.size).round(2)
  end

  def average_items_per_merchant_standard_deviation
    ave = average_items_per_merchant
    n = @se.merchants.all.size - 1
    ids = find_merchant_ids
    # is this a place where we can use the items method from the merchant class?
    items_per_merchant = ids.map do |id|
      @se.items.find_all_by_merchant_id(id).size
    end
    num = items_per_merchant.map do |item_number|
      (item_number - ave) ** 2
    end.reduce(:+) / n
    Math.sqrt(num).round(2)
  end

  def find_merchant_ids
    @se.merchants.all.map do |merch|
      merch.id
    end
  end

  def merchants_with_high_item_count
    baseline = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    # is this a place where we can use the items method from the merchant class?
    high_merchants = find_merchant_ids.find_all do |id|
      id if @se.items.find_all_by_merchant_id(id).size > baseline
    end
    high_merchants.map do |id|
      @se.merchants.find_by_id(id)
    end
  end

  def average_item_price_for_merchant(id)
    prices = @se.items.find_all_by_merchant_id(id).map do |item|
      item.unit_price
    end
    (prices.reduce(:+)/prices.size).round(2)
  end

  def average_average_price_per_merchant
    prices = @se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (prices.reduce(:+)/prices.length).round(2)
  end

  def golden_items
    all_items = @se.items.all.map { |item| item.unit_price }
    ave = all_items.reduce(:+) / all_items.count
    sum_of_diffs = all_items.map { |price| (price - ave)**2 }.reduce(:+)

    sd = Math.sqrt(sum_of_diffs/ (all_items.count - 1))
    base = ave + (sd*2)
    range = (base..BigDecimal::INFINITY)
    @se.items.find_all_by_price_in_range(range)
  end

  def average_invoices_per_merchant
    invoices = @se.merchants.all.map do |merchant|
      merchant.invoices.size.to_f
    end
    (invoices.reduce(:+)/invoices.size).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    ave = average_invoices_per_merchant
    n = @se.merchants.all.size - 1
    sum_of_squares = @se.merchants.all.map do |merchant|
      (merchant.invoices.size.to_f - ave)**2
    end.reduce(:+) / n
    Math.sqrt(sum_of_squares).round(2)
  end

  def top_merchants_by_invoice_count
    baseline = (average_invoices_per_merchant +
                average_invoices_per_merchant_standard_deviation * 2)
    @se.merchants.all.find_all do |merchant|
      merchant.invoices.size > baseline
    end
  end

  def bottom_merchants_by_invoice_count
    baseline = (average_invoices_per_merchant -
                average_invoices_per_merchant_standard_deviation *  2)
    @se.merchants.all.find_all do |merchant|
      merchant.invoices.size < baseline
    end
  end

  def top_days_by_invoice_count
    ave = @se.invoices.all.size / 7.0
    weekdays = @se.merchants.all.map do |merchant|
      merchant.invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
    end.flatten
    daily = Hash.new(0)
    weekdays.each{ |weekday| daily[weekday]+=1 }
    sum_of_squares = daily.values.map do |count|
      (count - ave)**2
    end.reduce(:+)/6
    sd = Math.sqrt(sum_of_squares).round(2)

    baseline = ave + sd
    result = []
    daily.each_pair do |day, count|
      result << day if count > baseline
    end
    result
  end

  def invoice_status(status)
    total = @se.invoices.all.size.to_f
    total_w_status = @se.invoices.find_all_by_status(status).size
    ((total_w_status / total)*100).round(2)
  end

  def total_revenue_by_date(date)
    ids = @se.invoices.find_all_by_date(date).map { |invoice| invoice.id }
    iis = ids.map{ |id| @se.invoice_items.find_all_by_invoice_id(id) }.flatten
    iis.map do |ii|
      ii.quantity * ii.unit_price
    end.reduce(:+)
  end

  def revenue_by_merchant(id)
    invoices = @se.invoices.all.find_all{|invoice| invoice.merchant_id == id}
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
    ids = @se.merchants.all.map{ |merchant| merchant.id }#.reject{|id| revenue_by_merchant(id).nil? }
    zipped = ids.map{|id| revenue_by_merchant(id) }.zip(ids.map{|id| @se.merchants.find_by_id(id) })
    # array = [1,2,3,4,nil,5,6]
    # array.map.with_index { |element, index| array[index] = 0 if element == nil }
    zipped.map do |pairs|
      pairs.map.with_index{ |pair, index| pairs[index] = BigDecimal.new(0) if pair == nil }
    end
    ranked = zipped.sort_by{|pair| pair[0] }.reverse
    ranked.map{ |pair| pair[1] }
  end

  def merchants_with_pending_invoices
    pending_invoices = @se.invoices.find_all_by_status(:pending)
    ids = pending_invoices.map{|invoice| invoice.merchant_id }
    ids.map{|id| @se.merchants.find_by_id(id) }.uniq
  end

  def merchants_with_only_one_item
    @se.merchants.all.find_all{|merchant| merchant.items.size == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    all_items = @se.merchants.all.map do |merchant|
      merchant.items
    end
    month_items = all_items.find_all do |items|
      items.find_all do |item|
        Date::MONTHNAMES[item.created_at.month] == month_name
      end
    end.flatten
    merchant_ids = month_items.map{|item| item.merchant_id }.uniq!
    merchant_ids.map{|id| @se.merchants.find_by_id(id) }
  end


  def most_sold_item_for_merchant
    "pizza"
  end

  def best_item_for_merchant
    "pizza"
  end

end
