require_relative 'test_helper'

require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test
  attr_reader :transaction, :repository

  def setup
    data = {
      id:                          '1',
      invoice_id:                  '1',
      credit_card_number:          '4654405418249632',
      credit_card_expiration_date: '',
      result:                      'success',
      created_at:                  '2012-03-27 14:54:09 UTC',
      updated_at:                  '2012-03-27 14:54:09 UTC'
    }

    @repository = Minitest::Mock.new
    @transaction = Transaction.new(data, repository)
  end

  def test_transaction_attributes
    assert_equal 1, @transaction.id
    assert_equal 1, @transaction.invoice_id
    assert_equal '4654405418249632', @transaction.credit_card_number
    assert_equal '', @transaction.credit_card_expiration_date
    assert_equal 'success', @transaction.result
    assert_class = Date, @transaction.created_at
    assert_equal = Date, @transaction.updated_at
  end
end
