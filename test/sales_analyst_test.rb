require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })

    @sa = SalesAnalyst.new(se)

  end

  def test_it_finds_the_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_finds_the_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_which_merchants_sell_the_most_items
    assert_equal 52, @sa.merchants_with_high_item_count.size
  end

  def test_it_finds_the_average_price_for_a_merchants_items
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105).to_f
  end

  def test_average_average_can_find_the_average_of_the_averages
    assert_equal 350.29, @sa.average_average_price_per_merchant.to_f
  end

  def test_it_returns_all_of_the_items_two_standard_deviations_above_average
    assert_equal 5, @sa.golden_items.size
  end

  def test_average_invoices_per_merchant_returns_average_number_invoices_per_merchant
    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_returns_the_standard_deviation
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_above_average
    assert_equal 12, @sa.top_merchants_by_invoice_count.size
  end

  def test_it_finds_merchants_with_invoice_count_two_standard_deviations_below_average
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.size
  end

  def test_it_finds_which_days_are_invoices_created_at_more_than_one_standard_deviation_above_the_mean
    assert_equal ["Wednesday"] , @sa.top_days_by_invoice_count
  end

  def test_it_finds_the_percentage_of_invoices_with_given_status
    assert_equal 29.55, @sa.invoice_status(:pending)
  end

  def test_it_finds_the_total_revenue_by_date
    date = Time.parse("2012-07-21")
    assert_equal 41498.12, @sa.total_revenue_by_date(date).to_f
  end

  def test_it_finds_the_revenue_per_merchant
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)
    assert_equal 0.0, @sa2.revenue_by_merchant(12334165).to_f
  end

  def test_it_returns_the_given_nimber_of_top_revenue_earners
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)
    assert_equal "handicraftcallery", @sa2.top_revenue_earners(3).first.name
    assert_equal 20, @sa.top_revenue_earners.size
  end

  def test_it_finds_which_merchants_have_pending_invoices
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)
    assert_equal 467, @sa.merchants_with_pending_invoices.size
    assert_equal Merchant, @sa.merchants_with_pending_invoices.first.class
  end

  def test_it_returns_merchants_with_only_one_item
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)

    #this test takes only slightly longer against the full data set

    assert_equal 10, @sa2.merchants_with_only_one_item.size
    assert_equal Merchant, @sa2.merchants_with_only_one_item.first.class
  end

  def test_it_returns_merchants_with_only_one_item_registered_in_a_month
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)

    assert_equal 2,
    @sa2.merchants_with_only_one_item_registered_in_month("January").size
    assert_equal Merchant,
    @sa2.merchants_with_only_one_item_registered_in_month("January").first.class
  end

  def test_it_returns_the_most_sold_item_for_a_merchant
    se2 = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa2 = SalesAnalyst.new(se2)
    assert_equal 4, @sa.most_sold_item_for_merchant(12334132).size
    assert_equal Item, @sa.most_sold_item_for_merchant(12334132).first.class
  end

  def test_it_returns_the_best_item_for_a_merchant
    assert_equal "White Nectarine Bubble Bath", @sa.best_item_for_merchant(12334132).name
    assert_equal Item, @sa.best_item_for_merchant(12334132).class
  end
end
