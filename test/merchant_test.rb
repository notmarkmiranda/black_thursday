require_relative 'test_helper'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def test_it_knows_its_repo
    assert_equal MerchantRepository, @m_repo.class
  end

  def test_it_can_return_ids
    assert_equal 12334105, @merchant.id
  end

  def test_it_can_return_names
    assert_equal "Shopin1901", @merchant.name
  end

  def test_it_can_return_created_at
    time = Time.strptime("2010-12-10 00:00:00 -0700", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @merchant.created_at
  end

  def test_it_can_return_updated_at
    time = Time.strptime("2011-12-04 00:00:00 -0700", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @merchant.updated_at
  end

  def test_it_knows_its_items
    assert_equal 3, @merchant.items.size
  end

  def test_it_knows_its_invoices
    assert_equal 2, @merchant.invoices.size
  end

  def test_it_knows_its_customers
    assert_equal 2, @merchant.customers.size
  end

  def test_can_return_only_successful_invoices
    assert_equal 2, @merchant.successful_invoices.size
  end

  def test_can_return_revenue_for_single_merchant
    assert_equal 891.09, @merchant.revenue.to_f
  end

end
