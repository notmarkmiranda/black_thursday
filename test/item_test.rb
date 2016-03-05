require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test
  attr_accessor :item, :items_repo

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items3.csv",
      :merchants => "./fixtures/merchants3.csv",
      :invoices => "./fixtures/invoices3.csv"
      })
    @items_repo = se.items
    @item = @items_repo.all[0]
  end

  def test_it_returns_the_integer_id_of_the_item
    assert_equal 263395237, @item.id
  end

  def test_it_returns_the_name_of_the_item
    assert_equal "510+ RealPush Icon Set", @item.name
  end

  def test_it_returns_the_description_of_the_item
    assert @item.description.include?("bublews")
  end

  def test_it_returns_the_price_of_the_item
    assert_equal BigDecimal(12), @item.unit_price
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_first_created
    time = Time.strptime("2016-01-11 09:34:06 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @item.created_at
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_last_modified
    time = Time.strptime("2007-06-04 21:35:10 UTC",  "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @item.updated_at
  end

  def test_it_returns_the_integer_merchant_id_of_the_item
    assert_equal 12334114, @item.merchant_id
  end

  def test_merchant_item_can_find_its_merchant
    item = @items_repo.find_by_id(263395237)
    assert_equal "Mark Miranda", item.merchant.name
  end

end
