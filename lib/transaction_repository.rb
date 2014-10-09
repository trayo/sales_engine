require_relative 'transaction'

class TransactionRepository

  attr_reader :transactions

  def initialize(transactions = [])
    @transactions = transactions
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_attribute(:invoice_id, invoice_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_attribute(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by_attribute(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_all_by_attribute(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_by_result(result)
    find_by_attribute(:result, result)
  end

  def find_all_by_result(result)
    find_all_by_attribute(:result, result)
  end

  private

  def find_by_attribute(attribute, value)
    transactions.find {|transaction| transaction.public_send(attribute) == value}
  end

  def find_all_by_attribute(attribute, value)
    transactions.find_all {|transaction| transaction.public_send(attribute) == value}
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end
end
