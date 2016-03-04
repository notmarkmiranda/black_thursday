require 'bigdecimal'

class Item
  attr_accessor :item_data, :item_repository

  def initialize(item_data, item_repository)
    @item_data = item_data
    @item_repository = item_repository
  end

  def id
    item_data[0].to_i
  end

  def name
    item_data[1]
  end

  def description
    item_data[2]
  end

  def unit_price
    BigDecimal.new(item_data[3]) / BigDecimal.new(100)
  end

  def merchant_id
    item_data[4].to_i
  end


  def created_at
    Time.parse(item_data[5])
  end

  def updated_at
    Time.parse(item_data[6])
  end

  def merchant
    @item_repository.engine.merchants.find_by_id(self.merchant_id)
  end

end
