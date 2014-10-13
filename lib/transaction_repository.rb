require_relative 'transaction'
require_relative 'file_loader'

class TransactionRepository
  attr_reader :transactions, :engine

  def initialize(engine, transactions = '')
    @engine       = engine
    transactions.class == Array ? @transactions = transactions : @transactions = load_file(transactions)
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_by_invoice_id(invoice_id)
    transactions.find { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find { |transaction| transaction.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find_all { |transaction| transaction.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction.result == result }
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result }
  end

  def invoice(invoice_id)
    engine.transaction_invoice(invoice_id)
  end

  private

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end

  def load_file(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| Transaction.new(row, self) }
  end
end
