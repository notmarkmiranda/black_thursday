require_relative 'test_helper'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @merchants_repo = se.merchants
    @merchant = @merchants_repo.all[0]
  end

  def test_it_knows_its_repo
    assert_equal MerchantRepository, @merchants_repo.class
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
    assert_equal 10, @merchant.invoices.size
  end

  def test_it_knows_its_customers
    assert_equal 10, @merchant.customers.size
  end

  def test_can_return_only_successful_invoices
    assert_equal 5, @merchant.successful_invoices.size
  end

  def test_can_return_revenue_for_single_merchant
    assert_equal 73777.17, @merchant.revenue.to_f
  end

end
