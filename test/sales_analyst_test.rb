require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../test/preload'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def test_it_finds_the_average_items_per_merchant
    assert_equal 65.1, @sa.average_items_per_merchant
  end

  def test_it_finds_the_standard_deviation
    assert_equal 62.57, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_which_merchants_sell_the_most_items
    assert_equal 0, @sa.merchants_with_high_item_count.size
  end

  def test_it_finds_the_average_price_for_a_merchants_items
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105).to_f
  end

  def test_average_average_can_find_the_average_of_the_averages
    assert_equal 38.02, @sa.average_average_price_per_merchant.to_f
  end

  def test_it_returns_all_of_the_items_two_standard_deviations_above_average
    assert_equal 5, @sa.golden_items.size
  end

  def test_average_invoices_per_merchant_returns_average_number_invoices_per_merchant
    assert_equal 1.0, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_returns_the_standard_deviation
    assert_equal 0.45, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_above_average
    assert_equal 2, @sa.top_merchants_by_invoice_count.size
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_below_average
    assert_equal 2, @sa.bottom_merchants_by_invoice_count.size
  end

  def test_it_finds_which_days_are_invoices_created_at_more_than_one_standard_deviation_above_the_mean
    assert_equal ["Friday"] , @sa.top_days_by_invoice_count
  end

  def test_it_finds_the_percentage_of_invoices_with_given_status
    assert_equal 26.09, @sa.invoice_status(:pending)
  end

  def test_it_finds_the_total_revenue_by_date
    date = Time.parse("2012-07-21")
    assert_equal 0.0, @sa.total_revenue_by_date(date).to_f
  end

  def test_it_finds_the_revenue_per_merchant

    assert_equal 0.0, @sa.revenue_by_merchant(12334165).to_f
  end

  def test_it_returns_the_given_nimber_of_top_revenue_earners
    assert_equal "handicraftcallery", @sa.top_revenue_earners(3).first.name
    assert_equal 20, @sa.top_revenue_earners.size
    assert_equal 12334141, @sa.top_revenue_earners.last.id
  end

  def test_it_finds_which_merchants_have_pending_invoices

    assert_equal 10, @sa.merchants_with_pending_invoices.size
    assert_equal Merchant, @sa.merchants_with_pending_invoices.first.class
  end

  def test_it_returns_merchants_with_only_one_item
    assert_equal 10, @sa.merchants_with_only_one_item.size
    assert_equal Merchant, @sa.merchants_with_only_one_item.first.class
  end

  def test_it_returns_merchants_with_only_one_item_registered_in_a_month
    assert_equal 2,
    @sa.merchants_with_only_one_item_registered_in_month("January").size
    assert_equal Merchant,
    @sa.merchants_with_only_one_item_registered_in_month("January").first.class
  end

  def test_it_returns_the_most_sold_item_for_a_merchant
    assert_equal 1, @sa.most_sold_item_for_merchant(12334112).size
    assert_equal Item, @sa.most_sold_item_for_merchant(12334112).first.class
  end

  def test_it_returns_the_best_item_for_a_merchant
    assert_equal "Knitted wool hat", @sa.best_item_for_merchant(12334105).name
    assert_equal Item, @sa.best_item_for_merchant(12334105).class
  end
end
