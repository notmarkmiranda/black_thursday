require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :all, :repo
  attr_accessor :engine

  def initialize(merchants, engine = nil)
    @merchants = merchants
    @all = merchants
    @engine = engine
    create_new_merchants(merchants)
  end

  def create_new_merchants(raw_merchants, repo = nil)
    raw_merchants.map do |row|
      Merchant.new({:id  => row[:id].to_i,
                   :name => row[:name],
                   :created_at => row[:created_at],
                   :updated_at => row[:updated_at]
                  }, self)
    end
  end
  # def items
  #   @items = @engine.items.find_all_by_merchant_id(id)
  # end

  def find_size
    @merchants.size
  end

  def find_by_id(id)
    @merchants.find { |key| key.id == id }
  end

  def find_by_name(name)
    @merchants.find { |key| key.name.downcase.include?(name.downcase) }
  end

  def find_all_by_name(name)
    @merchants.find_all do |key|
      key.name.downcase.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
