require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv"
      })
    @invrepo = se.invoices
  end

  def test_can_return_all_items
    assert_equal 50, @invrepo.all.size
  end

  def test_can_find_items_by_invoice_id
    assert_equal 1, @invrepo.find_by_id(1).customer_id
  end

  def test_can_find_all_by_customer_id
    assert_equal 8, @invrepo.find_all_by_customer_id(1).size
  end

  def test_can_find_all_by_merchant_id
    assert_equal 12, @invrepo.find_all_by_merchant_id(12334105).size
  end

  def test_can_find_all_by_status
    assert_equal 17, @invrepo.find_all_by_status(:pending).size
  end

end
