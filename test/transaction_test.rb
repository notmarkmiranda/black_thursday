require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class TransactionTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items => "./fixtures/items.csv",
      :merchants => "./fixtures/merchants.csv",
      :invoices => "./fixtures/invoices.csv",
      :invoice_items => "./fixtures/invoice_items.csv",
      :transactions => "./fixtures/transactions.csv",
      :customers => "./fixtures/customers.csv"
      })
      @tran_repo = se.transactions
      @transaction = @tran_repo.all[0]
  end

  def test_id_returns_the_transaction_id
    assert_equal 1, @transaction.id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 2179, @transaction.invoice_id
  end

  def test_credit_card_number_returns_the_credit_card_number
    cc = 4068631943231473
    assert_equal cc, @transaction.credit_card_number
  end

  def test_credit_card_expiration_date_returns_the_credit_card_expiration
    assert_equal "0217", @transaction.credit_card_expiration_date
  end

  def test_result_returns_the_result
    assert_equal "success", @transaction.result
  end

  def test_created_at_returns_Time_instance_for_date_invoice_item_was_created
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @transaction.created_at
  end

  def test_updated_at_returns_Time_instance_for_date_invoice_item_last_updated
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @transaction.updated_at
  end
end
