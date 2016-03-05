require_relative 'sales_engine'

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
    baseline = average_items_per_merchant + average_items_per_merchant_standard_deviation
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

end
