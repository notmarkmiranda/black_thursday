require 'csv'
require_relative 'merchant'
require_relative 'sales_engine'

class MerchantRepository
  attr_accessor :merchants, :engine

  def initialize(merchants_data, engine)
    @engine = engine
    @merchants = merchants_data.map do |merchant|
      Merchant.new(merchant, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id.to_i }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
