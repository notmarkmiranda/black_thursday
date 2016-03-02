require './test/test_helper'
require './lib/salesengine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
  end

  def test_items_returns_instance_of_all_merchant_items
    assert_equal 475, @se.merchants.merchant.size
  end

  def test_can_find_merchant_by_id
    merch = @se.merchants
    assert_equal "Keckenbauer", merch.find_by_id("12334123").name
  end
  # items returns an instance of ItemRepository with all the item instances loaded
  # merchants returns an instance of MerchantRepository with all the merchant instances loaded

end
