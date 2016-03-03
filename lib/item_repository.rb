require_relative 'item'
require 'bigdecimal'

class ItemRepository
  attr_reader :merchants, :all, :repo
  attr_accessor :engine

  def initialize(items, engine = nil)
    @items = items
    @engine = engine
    create_new_items(items)
  end

  def create_new_items(raw_items, repo = nil)
    raw_items.map do |row|
      Item.new({:id          => row[:id].to_i,
                :name        => row[:name],
                :description => row[:description],
                :unit_price  => BigDecimal.new(row[:unit_price][0..-3] + "." + row[:unit_price][-2..-1]),
                :created_at  => Time.strptime(row[:created_at], "%Y-%m-%d %H:%M:%S %Z"),
                :updated_at  => Time.strptime(row[:updated_at], "%Y-%m-%d %H:%M:%S %Z"),
                :merchant_id => row[:merchant_id].to_i
              }, self)
    end
  end

  def find_size
    @items.count
  end

  def all
    @items
  end

  def find_by_id(num)
    @items.find do |item|
      item.id.to_i == num
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

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def inspect
  "#<#{self.class} #{@items.size} rows>"
  end

end
