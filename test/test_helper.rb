require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require 'pry'


class Minitest::Test
    def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./fixtures/merchants_4.csv",
      :invoices => "./fixtures/invoices_4.csv",
      :invoice_items => "./fixtures/invoice_items_4.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    @sa = SalesAnalyst.new(se)

    @cust_repo = se.customers
    @customer = @cust_repo.all[0]

    @m_repo = se.merchants
    @merchant = @m_repo.all[0]

    @i_repo = se.items
    @item = @i_repo.all[0]

    @inv_repo = se.invoices
    @invoice = @inv_repo.all[0]

    @iirepo = se.invoice_items
    @ii = @iirepo.all[0]

    @trans_repo = se.transactions
    @transaction = @trans_repo.all[0]
  end
end
