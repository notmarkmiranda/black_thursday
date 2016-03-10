require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'


class ItemRepositoryTest < Minitest::Test


  def test_can_return_all_items
    assert_equal 1367, @i_repo.all.size
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
    assert_equal 41, @i_repo.find_all_by_price(12).size
  end

  def test_can_find_all_items_by_price_in_range
    assert_equal 59, @i_repo.find_all_by_price_in_range(11.99..13.51).size
  end

  def test_can_find_all_by_merchant_id
    assert_equal [263396209, 263500440, 263501394], @i_repo.find_all_by_merchant_id(12334105).map { |item| item.id }
  end

  def test_it_inspects
    assert_equal "#<ItemRepository 1367 rows>", @i_repo.inspect
  end

end
