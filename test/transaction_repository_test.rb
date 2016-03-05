require_relative 'test_helper'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv",
      :invoice_items => "./fixtures/invoice_items.csv",
      :transactions => "./fixtures/transactions.csv",
      :customers => "./fixtures/customers.csv"
      })
      @tranrepo = se.transactions
  end

  def test_all_returns_all_transactions
    assert_equal 4985, @tranrepo.all.size
  end

  def test_find_by_id_returns_a_transaction_matching_the_given_id
    assert_equal 4068631943231473, @tranrepo.find_by_id(1).credit_card_number
  end

  def test_find_all_by_invoice_id_returns_all_transactions_matching_the_given_id
    assert_equal 1, @tranrepo.find_all_by_invoice_id(1298).size
  end

  def test_find_all_by_credit_card_number_returns_all_tx_matching_given_cc_number
    assert_equal 1, @tranrepo.find_all_by_credit_card_number(4068631943231473).size
  end

  def test_find_all_by_result_returns_all_transactions_matching_given_result
    assert_equal 827, @tranrepo.find_all_by_result("failed").size
  end
end
