require './lib/salesengine'

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
    find_merchant_ids.map do |id|
      (@se.items.find_all_by_merchant_id(id).count - ave) ** 2
    end.reduce(:+) / 2
  end

  def merchants_with_high_item_count
    best = find_merchant_ids.map do |id|
      [@se.items.find_all_by_merchant_id(id).count, @se.merchants.find_by_id(id).name]
    end.sort[-3..-1]
    best.map do |array|
      array[1]
    end
  end

end
