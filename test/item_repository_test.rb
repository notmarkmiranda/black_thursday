require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'


class ItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv",
      :invoice_items => "./fixtures/invoice_items.csv",
      :transactions => "./fixtures/transactions.csv",
      :customers => "./fixtures/customers.csv"
      })
    @i_repo = se.items
  end

  def test_can_return_all_items
    assert_equal 12, @i_repo.all.size
  end

  def test_can_find_items_by_id
    assert_equal "510+ RealPush Icon Set", @i_repo.find_by_id(263395237).name
  end

  def test_can_find_item_by_name
    assert_equal 263395237, @i_repo.find_by_name("510+ RealPush Icon Set").id
  end

  def test_can_find_all_with_description
    assert_equal [263395237], @i_repo.find_all_with_description("bublews").map { |item| item.id }
  end

  def test_can_find_all_by_price
    assert_equal [263395237], @i_repo.find_all_by_price(12).map { |item| item.id }
  end

  def test_can_find_all_items_by_price_in_range
    assert_equal [263395237, 263395617, 263395721], @i_repo.find_all_by_price_in_range(11.99..13.51).map{ |item| item.id }
  end

  def test_can_find_all_by_merchant_id
    assert_equal [263395617, 263395721], @i_repo.find_all_by_merchant_id(12334105).map { |item| item.id }
  end

  def test_it_inspects
    assert_equal "#<ItemRepository 12 rows>", @i_repo.inspect
  end

end
