require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :engine

  def initialize(invoices_data, engine)
    @engine = engine
    @invoices = invoices_data.map do |invoice|
      Invoice.new(invoice, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id.to_i }
  end

  def find_all_by_customer_id(id)
    @invoices.find_all { |invoice| invoice.customer_id == id.to_i }
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all { |invoice| invoice.merchant_id == id.to_i }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status.to_sym}
  end

  def inspect
  "#<#{self.class} #{@invoices.size} rows>"
  end

end
