# require_relative 'invoice_repository'

class Invoice
  attr_accessor :invoice_data, :invoice_repository

  def initialize(invoice_data, invoice_repository)
    @invoice_data = invoice_data
    @invoice_repository = invoice_repository
  end

  def id
    @invoice_data[0].to_i
  end

  def customer_id
    invoice_data[1].to_i
  end

  def merchant_id
    invoice_data[2].to_i
  end

  def status
    invoice_data[3].to_sym
  end

  def created_at
    Time.parse(invoice_data[4])
  end

  def updated_at
    Time.parse(invoice_data[5])
  end

  def merchant
    @invoice_repository.engine.merchants.find_by_id(self.merchant_id)
  end

  def invoice_items
    invoice_repository.engine.invoice_items.find_all_by_merchant_id(self.id)
  end#returns 0 if the invoice_items_status_is_pending..is that right?

  def items
    invoice_repository.engine.invoice_items.
    find_all_by_invoice_id(self.id).map do |obj|
      obj.item_id
    end.map do |item_id|
      invoice_repository.engine.items.find_by_id(item_id)
    end
  end

  def transactions
    invoice_repository.engine.transactions.
    find_all_by_invoice_id(self.id).find_all do |obj|
      obj if obj.invoice_id == id
    end
  end

  def customer
    cid = self.customer_id
    invoice_repository.engine.customers.find_by_id(cid)
  end

  def is_paid_in_full?
    invoice_repository.engine.transactions.
    find_all_by_invoice_id(self.id).any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    if is_paid_in_full?
      invoice_repository.engine.invoice_items.
      find_all_by_invoice_id(self.id).map do |item|
        item.quantity * item.unit_price
      end.reduce(:+)
    end
  end

  def all_failed_transactions?
    transactions.none?{ |transaction| transaction.result == "success"}
  end

end
