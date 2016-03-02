require './test/test_helper'
require './lib/salesengine'

class SalesEngineTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @m_o = se.merchants
    @i_o = se.items

  end

  def test_items_returns_instance_of_all_merchant_items
    assert_equal 475, @m_o.merchant.size
  end

  def test_can_find_merchant_by_id
    assert_equal "Keckenbauer", @m_o.find_by_id("12334123").name
  end

  def test_can_find_merchant_by_name_or_partial_name
    assert_equal "GoldenRayPress", @m_o.find_by_name("GOLDENRAYPRESS").name
    assert_equal "GoldenRayPress", @m_o.find_by_name("golDENray").name

  end

  def test_can_find_item_by_id
    assert_equal "510+ RealPush Icon Set", @i_o.find_by_id("263395237").name
  end


end