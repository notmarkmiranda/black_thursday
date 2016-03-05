require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items3.csv",
      :merchants => "./fixtures/merchants3.csv",
      :invoices => "./fixtures/invoices3.csv"
      })
    @m_repo = se.merchants
    @i_repo = se.items
    @inv_repo = se.invoices

  end

  def test_items_returns_instance_of_all_merchant_items
    assert_equal 4, @m_repo.merchants.size
  end

  def test_can_find_merchant_by_id
    assert_equal "Candisart", @m_repo.find_by_id(12334112).name
  end

  def test_can_find_merchant_by_name_or_partial_name
    assert_equal "Candisart", @m_repo.find_by_name("CANDISART").name
    assert_equal "Candisart", @m_repo.find_by_name("candi").name
  end

  def test_can_find_item_by_id
    assert_equal "510+ RealPush Icon Set", @i_repo.find_by_id(263395237).name
  end

  def test_it_can_find_items_by_merchant_id
    assert_equal 4, @i_repo.find_all_by_merchant_id(12334112).size
  end


end
