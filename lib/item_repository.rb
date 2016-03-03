require_relative 'item'
require 'bigdecimal'

class ItemRepository

  def initialize(items = [])
    @items = items
  end

  def find_size
    @items.count
  end

  def all
    @items
  end

  def find_by_id(num)
    @items.find do |item|
      item.id == num
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase.include?(name.downcase)
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(low, high)
    @items.find_all do |item|
      item.unit_price > low && item.unit_price < high
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

end
