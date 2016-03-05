require_relative 'sales_engine'
require_relative 'invoice_item'

class InvoiceItemRepository

  def initialize(invoice_items_data, engine)
    @engine = engine
    @invoice_items = invoice_items_data.map do |invoice_item|
      InvoiceItem.new(invoice_item, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |ii| ii.id == id.to_i }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |ii| ii.item_id == item_id.to_i }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all { |ii| ii.invoice_id == invoice_id.to_i }
  end

  def inspect
  "#<#{self.class} #{@invoice_items.size} rows>"
  end

end
