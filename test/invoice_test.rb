require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @invoice_repo = se.invoices
    @invoice = @invoice_repo.all[0]
  end


  def test_can_return_the_id_of_the_invoice
    assert_equal 1, @invoice.id
  end

  def test_can_return_the_customer_id_of_the_invoice
    assert_equal 1, @invoice.customer_id
  end

  def test_can_return_the_merchant_id_of_the_invoice
    assert_equal 12335938, @invoice.merchant_id
  end

  def test_can_return_the_status_of_invoice
    assert_equal :pending, @invoice.status
  end

  def test_can_return_created_at
    time = Time.strptime("2009-02-07", "%Y-%m-%d")
    assert_equal time, @invoice.created_at
  end

  def test_can_return_updated_at
    time = Time.strptime("2014-03-15", "%Y-%m-%d")
    assert_equal time, @invoice.updated_at
  end

  # def test_items_can_return_items_on_invoice
  #   assert_equal [7], @invoice.items
  # end

end
