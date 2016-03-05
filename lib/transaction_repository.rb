require_relative 'transaction'

class TransactionRepository

  def initialize(transactions_data, engine)
    @engine = engine
    @transactions = transactions_data.map do |transaction|
      Transaction.new(transaction, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id.to_i
    end
  end

  def find_all_by_credit_card_number(cc)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc.to_i
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def inspect
  "#<#{self.class} #{@transactions.size} rows>"
  end


end
