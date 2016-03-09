require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class CustomerTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
      @cust_repo = se.customers
      @customer = @cust_repo.all[0]
  end

  def test_id_returns_the_id
    assert_equal 1, @customer.id
  end

  def test_first_name_returns_the_first_name
    assert_equal "Joey", @customer.first_name
  end

  def test_last_name_returns_the_last_name
    assert_equal "Ondricka", @customer.last_name
  end

  def test_created_at_returns_Time_instance_for_date_invoice_item_was_created
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @customer.created_at
  end

  def test_updated_at_returns_Time_instance_for_date_invoice_item_was_updated
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @customer.updated_at
  end

end
