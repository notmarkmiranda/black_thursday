require 'bigdecimal'

class InvoiceItem
  attr_accessor :invoice_item_data, :invoice_item_repository

  def initialize(invoice_item_data, invoice_item_repository)
    @invoice_item_data = invoice_item_data
    @invoice_item_repository = invoice_item_repository
  end

  def id
    invoice_item_data[0].to_i
  end

  def item_id
    invoice_item_data[1].to_i
  end

  def invoice_id
    invoice_item_data[2].to_i
  end

  def quantity
    invoice_item_data[3].to_i
  end

  def unit_price
    BigDecimal.new(invoice_item_data[4]) / BigDecimal.new(100)
  end

  def created_at
    Time.parse(invoice_item_data[5])
  end

  def updated_at
    Time.parse(invoice_item_data[6])
  end

end
# id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
