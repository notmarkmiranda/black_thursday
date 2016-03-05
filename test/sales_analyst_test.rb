require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv"
      })

    @sa = SalesAnalyst.new(se)

  end

  def test_it_finds_the_average_items_per_merchant
    assert_equal 3.0, @sa.average_items_per_merchant
  end

  def test_it_finds_the_standard_deviation
    assert_equal 1.83, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_which_merchants_sell_the_most_items
    assert_equal ["MiniatureBikez"], @sa.merchants_with_high_item_count.map{ |merchant| merchant.name }
  end

  def test_it_finds_the_average_price_for_a_merchants_items
    assert_equal 13.25, @sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_can_find_the_average_of_the_averages
    assert_equal 49.91, @sa.average_average_price_per_merchant
  end

  def test_it_returns_all_of_the_items_two_standard_deviations_above_average
    result = ["Course contre la montre"]
    assert_equal result, @sa.golden_items.map { |item| item.name}
  end

  def test_average_invoices_per_merchant_returns_average_number_invoices_per_merchant
    assert_equal 12.50, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_returns_the_standard_deviation
    assert_equal 5, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_above_average
    assert_equal [] , @sa.top_merchants_by_invoice_count
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_below_average
    assert_equal [] , @sa.bottom_merchants_by_invoice_count
  end

  def test_it_finds_which_days_are_invoices_created_at_more_than_one_standard_deviation_above_the_mean
    assert_equal ["Friday"] , @sa.top_days_by_invoice_count
  end

  def test_it_finds_the_percentage_of_invoices_with_given_status
    assert_equal 34.0, @sa.invoice_status(:pending)
  end
end
