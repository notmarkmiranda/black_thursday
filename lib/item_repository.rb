require_relative 'item'

class ItemRepository
  attr_accessor :items, :engine

  def initialize(items_data, engine)
    @items = items_data.map do |item|
      Item.new(item, self)
    end
    @engine = engine
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |item| item.id == id.to_i }
  end

  def find_by_name(name)
    items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(desc)
    items.find_all { |item| item.description.downcase.include?(desc.downcase) }
  end

  def find_all_by_price(price)
    items.find_all { |item| item.unit_price.to_f == price }
  end

  def find_all_by_price_in_range(range)
    items.find_all { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merch_id)
    items.find_all { |item| item.merchant_id == merch_id }
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
