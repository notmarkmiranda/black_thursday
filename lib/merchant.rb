require_relative 'item_repository'

class Merchant
  attr_accessor :merchant_data, :merchant_repository

  def initialize(merchant_data, merchant_repository)
    @merchant_data = merchant_data
    @merchant_repository = merchant_repository
  end

  def id
    merchant_data[0].to_i
  end

  def name
    merchant_data[1]
  end

  def items
    merchant_repository.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    merchant_repository.engine.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end.uniq
  end


end
