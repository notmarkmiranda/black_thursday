require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items3.csv",
      :merchants => "./fixtures/merchants3.csv"
      })

    @sa = SalesAnalyst.new(se)

  end

  def test_it_finds_the_average_items_per_merchant
    assert_equal 3.0, @sa.average_items_per_merchant
  end

  def test_it_finds_the_standard_deviation
    # puts @merch_ids
    assert_equal 2.16, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_which_merchants_sell_the_most_items
    result = ["Shopin1901", "Candisart", "MiniatureBikez"]
    assert_equal result, @sa.merchants_with_high_item_count.map { |merch| merch.name}
  end

  def test_it_finds_the_average_price_for_a_merchants_items
    assert_equal 12.83, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_returns_all_of_the_items_two_standard_deviations_above_average
    result = ["Course contre la montre"]
    assert_equal result, @sa.golden_items.map { |item| item.name}
  end

end
