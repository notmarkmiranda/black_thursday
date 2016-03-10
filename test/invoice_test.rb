require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceTest < Minitest::Test

  def test_can_return_the_id_of_the_invoice
    assert_equal 548, @invoice.id
  end

  def test_can_return_the_customer_id_of_the_invoice
    assert_equal 106, @invoice.customer_id
  end

  def test_can_return_the_merchant_id_of_the_invoice
    assert_equal 12334113, @invoice.merchant_id
  end

  def test_can_return_the_status_of_invoice
    assert_equal :shipped, @invoice.status
  end

  def test_can_return_created_at
    time = Time.strptime("2005-07-18", "%Y-%m-%d")
    assert_equal time, @invoice.created_at
  end

  def test_can_return_updated_at
    time = Time.strptime("2012-03-30", "%Y-%m-%d")
    assert_equal time, @invoice.updated_at
  end

  def test_it_knows_its_merchant
    assert_equal 12334113, @invoice.merchant.id
  end

  def test_it_knows_its_invoice_items
    assert_equal 0, @invoice.invoice_items.size
  end#is it 0 because the status is pending?

  def test_it_knows_its_items
    assert_equal 1, @invoice.items.size
  end

  def test_it_knows_its_transactions
    assert_equal 2, @invoice.transactions.size
  end

  def test_it_knows_its_customer
    assert_equal "Davonte", @invoice.customer.first_name
  end

  def test_it_knows_its_total
    result = 3152.32
    assert_equal result, @invoice.total.to_f
  end

  def test_it_knows_if_it_has_no_successful_transactions
    assert_equal false, @invoice.all_failed_transactions?
  end

end
