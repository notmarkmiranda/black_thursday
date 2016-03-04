require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'
require 'bigdecimal'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(merchants_data = nil, items_data = nil)
    @merchants = MerchantRepository.new(merchants_data, self)
    @items = ItemRepository.new(items_data, self)
  end


  def self.from_csv(path_hash)
    merchants_data = load_stuff(path_hash[:merchants])
    items_data = load_stuff(path_hash[:items])

    SalesEngine.new(merchants_data, items_data)
  end

  def self.load_stuff(path_hash)
    CSV.open(path_hash, headers: true)
  end

end
