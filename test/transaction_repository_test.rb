require_relative 'test_helper'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_all_returns_all_transactions
    assert_equal 4985, @trans_repo.all.size
  end

  def test_find_by_id_returns_a_transaction_matching_the_given_id
    assert_equal 4068631943231473, @trans_repo.find_by_id(1).credit_card_number
  end

  def test_find_all_by_invoice_id_returns_all_transactions_matching_the_given_id
    assert_equal 1, @trans_repo.find_all_by_invoice_id(1298).size
  end

  def test_find_all_by_cc_number_returns_all_tx_matching_given_cc_number
    cc_number = 4068631943231473
    assert_equal 1, @trans_repo.find_all_by_credit_card_number(cc_number).size
  end

  def test_find_all_by_result_returns_all_transactions_matching_given_result
    assert_equal 827, @trans_repo.find_all_by_result("failed").size
  end

  def test_it_inspects_itself
    assert_equal "#<TransactionRepository 4985 rows>", @trans_repo.inspect
  end

end
