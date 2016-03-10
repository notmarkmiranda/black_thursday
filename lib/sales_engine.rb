require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'analyst_assistant'


require 'csv'
require 'bigdecimal'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants, :invoices,
              :invoice_items, :transactions, :customers

  def initialize(merchants_data = nil, items_data = nil,
                invoices_data = nil, invoice_items_data = nil,
                transactions_data = nil, customers_data = nil)
    @merchants     = MerchantRepository.new(merchants_data, self)
    @items         = ItemRepository.new(items_data, self)
    @invoices      = InvoiceRepository.new(invoices_data, self)
    @invoice_items = InvoiceItemRepository.new(invoice_items_data, self)
    @transactions  = TransactionRepository.new(transactions_data, self)
    @customers     = CustomerRepository.new(customers_data, self)
  end


  def self.from_csv(path_hash)
    merchants_data     = load_stuff(path_hash[:merchants])
    items_data         = load_stuff(path_hash[:items])
    invoices_data      = load_stuff(path_hash[:invoices])
    invoice_items_data = load_stuff(path_hash[:invoice_items])
    transactions_data  = load_stuff(path_hash[:transactions])
    customers_data     = load_stuff(path_hash[:customers])

    SalesEngine.new(merchants_data, items_data,
                    invoices_data, invoice_items_data,
                    transactions_data, customers_data)
  end

  def self.load_stuff(path_hash)
    CSV.open(path_hash, headers: true)
  end

end
