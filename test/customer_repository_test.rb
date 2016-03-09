require_relative 'test_helper'
require_relative '../lib/sales_engine'


class CustomerRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
      @custrepo = se.customers
  end

  def test_all_returns_all_customers
    assert_equal 1000, @custrepo.all.size
  end

  def test_find_by_id_returns_the_customer_with_matching_id
    assert_equal "Eileen", @custrepo.find_by_id(18).first_name
  end

  def test_find_all_by_first_name_returns_all_customers_with_matching_first_name
    assert_equal 2, @custrepo.find_all_by_first_name("Mark").size
  end

  def test_find_all_by_last_name_returns_all_customers_with_matching_last_name
    assert_equal 62, @custrepo.find_all_by_last_name("ar").size
  end

  def test_find_all_by_first_name_and_find_all_by_last_name_are_case_insensitive
    assert_equal 62, @custrepo.find_all_by_last_name("AR").size
    assert_equal 2, @custrepo.find_all_by_first_name("mArK").size
  end

  def test_it_inspects
    assert_equal "#<CustomerRepository 1000 rows>", @custrepo.inspect
  end

end
