require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'
require 'bigdecimal'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(raw_items, raw_merchants)
    @items = ItemRepository.new(raw_items, self)
    @merchants = MerchantRepository.new(raw_merchants, self)
  end


  def self.from_csv(path_hash)
    load_items(path_hash[:items])

    load_merchants(path_hash[:merchants])

    se = SalesEngine.new(@raw_items, @raw_merchants)
  end

  def self.load_items(loc)
    @raw_items = CSV.open(loc, headers: true, header_converters: :symbol)
    # @items_list_format = raw_items.map do |row|
    #   ItemRepository.create_new_item(row)
      # Item.new({:id          => row[:id].to_i,
      #           :name        => row[:name],
      #           :description => row[:description],
      #           :unit_price  => BigDecimal.new(row[:unit_price][0..-3] + "." + row[:unit_price][-2..-1]),
      #           :created_at  => Time.strptime(row[:created_at], "%Y-%m-%d %H:%M:%S %Z"),
      #           :updated_at  => Time.strptime(row[:updated_at], "%Y-%m-%d %H:%M:%S %Z"),
      #           :merchant_id => row[:merchant_id].to_i
      #         }, se.items)
    # end
  end

  def self.load_merchants(loc)
    @raw_merchants = CSV.open(loc, headers:true, header_converters: :symbol)
    # @merchants_list_format = raw_merchants.map do |row|
    #   MerchantRepository.create_new_merchant(row)
      # Merchant.new({:id  => row[:id].to_i,
      #              :name => row[:name],
      #              :created_at => row[:created_at],
      #              :updated_at => row[:updated_at]
      #             }, se.items)
    # end
  end

end
