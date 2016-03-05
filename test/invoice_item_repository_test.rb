require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv",
      :invoice_items => "./fixtures/invoice_items.csv",
      :transactions => "./fixtures/transactions.csv",
      :customers => "./fixtures/customers.csv"
      })
      @iirepo = se.invoice_items
  end

  def test_can_return_all_invoice_items
    assert_equal 21830, @iirepo.all.size
  end

  def test_find_by_id_finds_an_invoice_item_by_id
    assert_equal 263432817, @iirepo.find_by_id(8).item_id
  end

  def test_find_by_id_returns_nil_if_the_invoice_item_does_not_exist
    assert_equal nil, @iirepo.find_by_id(21831)
  end

  def test_find_all_by_item_id_finds_all_items_matching_given_item_id
    assert_equal 22, @iirepo.find_all_by_item_id(263529264).size
  end

  def test_find_all_by_item_id_returns_an_empty_array_if_there_are_no_matches
    assert_equal [], @iirepo.find_all_by_item_id(12345)
  end

  def test_find_all_by_invoice_id_finds_all_items_matching_given_item_id
    assert_equal 8, @iirepo.find_all_by_invoice_id(1).size
  end

  def test_find_all_by_invoice_id_returns_an_empty_array_if_there_are_no_matches
    assert_equal [], @iirepo.find_all_by_invoice_id(30300101030303)
  end

end
