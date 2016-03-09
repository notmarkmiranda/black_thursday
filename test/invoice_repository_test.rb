require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @invrepo = se.invoices
  end

  def test_can_return_all_items
    assert_equal 4985, @invrepo.all.size
  end

  def test_can_find_items_by_invoice_id
    assert_equal 1, @invrepo.find_by_id(1).customer_id
  end

  def test_can_find_all_by_customer_id
    assert_equal 8, @invrepo.find_all_by_customer_id(1).size
  end

  def test_can_find_all_by_merchant_id
    assert_equal 10, @invrepo.find_all_by_merchant_id(12334105).size
  end

  def test_can_find_all_by_status
    assert_equal 1473, @invrepo.find_all_by_status(:pending).size
  end

  def test_it_can_find_all_invoices_by_date
    date = Time.parse("2005-11-12")
    assert_equal 1, @invrepo.find_all_by_date(date).size
  end

  def test_it_inspects_itself
    assert_equal "#<InvoiceRepository 4985 rows>", @invrepo.inspect
  end

end
