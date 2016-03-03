require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :se, :merch_ids
  def initialize(se)
    @se = se

  end

  def average_items_per_merchant
    average = @se.items.find_size.to_f / @se.merchants.find_size.to_f
    # (average * 1000).floor / 1000.0
  end

  def find_merchant_ids
    @merch_ids = @se.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
    ave = average_items_per_merchant
    n = @se.merchants.find_size - 1
    num = find_merchant_ids.map do |id|
      (@se.items.find_all_by_merchant_id(id).count - ave) ** 2
    end.reduce(:+) / n
    Math.sqrt(num).round(2)
  end

  def merchants_with_high_item_count
    best = find_merchant_ids.map do |id|
      [@se.items.find_all_by_merchant_id(id).count, @se.merchants.find_by_id(id)]
    end.sort[-3..-1]
    best.map do |array|
      array[1]
    end
  end

  def average_item_price_for_merchant(id)
    price = @se.items.find_all_by_merchant_id(id).map do |item|
      item.unit_price
    end.reduce(:+) / (@se.items.find_all_by_merchant_id(id)).count
    price.to_f.round(2)
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

end
