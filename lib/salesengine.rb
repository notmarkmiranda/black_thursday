require './lib/merchant_repository'
require './lib/item_repository'
require 'csv'

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
    # merchants_list = CSV.readlines path_hash[:merchants], headers: true, header_converters: :symbol
    # @merchants_object = MerchantRepository.new(merchants_list)

    SalesEngine.new(items_repo, merchants_repo)
  end

  def self.load_items(loc)
    raw_items = CSV.open(loc, headers: true, header_converters: :symbol)
    @items_list_format = raw_items.map do |row|
      Item.new({:id          => row[:id],
                :name        => row[:name],
                :description => row[:description],
                :unit_price  => row[:unit_price],
                :created_at  => row[:created_at],
                :updated_at  => row[:updated_at],
                :merchant_id => row[:merchant_id]
              })
    end
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
