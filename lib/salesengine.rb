require './lib/merchant_repository'
require './lib/item_repository'
require 'csv'
require 'bigdecimal'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(item_repo, merchants_repo)
    @items = item_repo
    @merchants = merchants_repo
  end


  def self.from_csv(path_hash)
    load_items(path_hash[:items])
    items_repo = ItemRespository.new(@items_list_format)

    load_merchants(path_hash[:merchants])
    merchants_repo = MerchantRepository.new(@merchants_list_format)

    SalesEngine.new(items_repo, merchants_repo)
  end

  def self.load_items(loc)
    raw_items = CSV.open(loc, headers: true, header_converters: :symbol)
    @items_list_format = raw_items.map do |row|
      # binding.pry
      Item.new({:id          => row[:id],
                :name        => row[:name],
                :description => row[:description],
                :unit_price  => BigDecimal.new(row[:unit_price][0..-3] + "." + row[:unit_price][-2..-1], 6),
                :created_at  => row[:created_at],
                :updated_at  => row[:updated_at],
                :merchant_id => row[:merchant_id]
              })
    end

    # potential opportunity to refactor starts here:
#     arr_of_items = []
#     CSV.foreach(path_hash.values_at(:items).pop, {:headers => true, :header_converters => :symbol}) do |row|
#       arr_of_items << Item.new(row.to_hash)
#     end
# ​
#     arr_of_merchants = []
#     CSV.foreach(path_hash.values_at(:merchants).pop, {:headers => true, :header_converters => :symbol}) do |row|
#       arr_of_merchants << Merchant.new(row.to_hash)
#     end

  end

  def self.load_merchants(loc)
    raw_merchants = CSV.open(loc, headers:true, header_converters: :symbol)
    @merchants_list_format = raw_merchants.map do |row|
      Merchant.new({:id  => row[:id],
                   :name => row[:name],
                   :created_at => row[:created_at],
                   :updated_at => row[:updated_at]
                  })
    end
  end

end
