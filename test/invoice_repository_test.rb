require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_can_return_all_items
    assert_equal 23, @inv_repo.all.size
  end

  def test_can_find_items_by_invoice_id
    assert_equal 1, @inv_repo.find_by_id(1).customer_id
  end

  def test_can_find_all_by_customer_id
    assert_equal 1, @inv_repo.find_all_by_customer_id(1).size
  end

  def test_can_find_all_by_merchant_id
    assert_equal 2, @inv_repo.find_all_by_merchant_id(12334105).size
  end

  def test_can_find_all_by_status
    assert_equal 6, @inv_repo.find_all_by_status(:pending).size
  end

  def test_it_can_find_all_invoices_by_date
    date = Time.parse("2005-11-12")
    assert_equal 0, @inv_repo.find_all_by_date(date).size
  end

  def test_it_inspects_itself
    assert_equal "#<InvoiceRepository 23 rows>", @inv_repo.inspect
  end

end
