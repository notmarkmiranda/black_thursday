require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_accessor :merchants, :engine

  def initialize(merchants_data, engine)
    @engine = engine
    @merchants = merchants_data.map do |merchant|
      Merchant.new(merchant, self)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id.to_i
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end


  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
