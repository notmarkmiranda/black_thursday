require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv",
      :invoice_items => "./fixtures/invoice_items.csv",
      :transactions => "./fixtures/transactions.csv",
      :customers => "./fixtures/customers.csv"
      })
    @merchants_repo = se.merchants
    @merchant = @merchants_repo.all[0]
  end

  def test_it_can_return_ids
    assert_equal 12334105, @merchant.id
  end

  def test_it_can_return_names
    assert_equal "Shopin1901", @merchant.name
  end


end
