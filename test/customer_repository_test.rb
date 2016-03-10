require_relative 'test_helper'
require_relative '../lib/sales_engine'


class CustomerRepositoryTest < Minitest::Test

  def test_all_returns_all_customers
    assert_equal 1000, @cust_repo.all.size
  end

  def test_find_by_id_returns_the_customer_with_matching_id
    assert_equal "Eileen", @cust_repo.find_by_id(18).first_name
  end

  def test_find_all_by_first_name_returns_all_customers_with_matching_first_name
    assert_equal 2, @cust_repo.find_all_by_first_name("Mark").size
  end

  def test_find_all_by_last_name_returns_all_customers_with_matching_last_name
    assert_equal 62, @cust_repo.find_all_by_last_name("ar").size
  end

  def test_find_all_by_first_name_and_find_all_by_last_name_are_case_insensitive
    assert_equal 62, @cust_repo.find_all_by_last_name("AR").size
    assert_equal 2, @cust_repo.find_all_by_first_name("mArK").size
  end

  def test_it_inspects
    assert_equal "#<CustomerRepository 1000 rows>", @cust_repo.inspect
  end

end
