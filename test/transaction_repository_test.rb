require_relative 'test_helper'

require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transactions, :transaction_repo, :sales_engine

  def setup
    @transactions = [
      {
        id:                          '1',
        invoice_id:                  '1',
        credit_card_number:          '4844518708741275',
        credit_card_expiration_date: '',
        result:                      'success',
        created_at:                  '2012-03-27 14:54:09 UTC',
        updated_at:                  '2012-03-27 14:54:09 UTC'
      },
      {
        id:                          '2',
        invoice_id:                  '2',
        credit_card_number:          '4580251236515201',
        credit_card_expiration_date: '',
        result:                      'success',
        created_at:                  '2012-03-27 14:54:09 UTC',
        updated_at:                  '2012-03-27 14:54:09 UTC'
      },
      {
        id:                          '3',
        invoice_id:                  '3',
        credit_card_number:          '4354495077693036',
        credit_card_expiration_date: '',
        result:                      'success',
        created_at:                  '2012-03-27 14:54:09 UTC',
        updated_at:                  '2012-03-27 14:54:09 UTC'
      },
      {
        id:                          '4',
        invoice_id:                  '3',
        credit_card_number:          '4654405418249632',
        credit_card_expiration_date: '2012-03-27',
        result:                      'failed',
        created_at:                  '2012-03-27 14:54:09 UTC',
        updated_at:                  '2012-03-27 14:54:09 UTC'
      },
      {
        id:                          '5',
        invoice_id:                  '4',
        credit_card_number:          '4654405418249632',
        credit_card_expiration_date: '',
        result:                      'failed',
        created_at:                  '2012-03-27 14:54:09 UTC',
        updated_at:                  '2012-03-27 14:54:09 UTC'
    }
    ].map {|row| Transaction.new(row, transaction_repo)}

    @sales_engine = Minitest::Mock.new
    @transaction_repo = TransactionRepository.new(sales_engine, transactions)
  end

  def test_all
    assert_equal 5, @transaction_repo.all.size
  end

  def test_random
    assert_class = Transaction, @transaction_repo.random
  end

  def test_find_by_id
    transaction = @transaction_repo.find_by_id(4)
    assert_equal 4, transaction.id
  end

  def test_find_by_invoice_id
    transaction = @transaction_repo.find_by_invoice_id(2)
    assert_equal 2, transaction.invoice_id
  end

  def test_find_all_by_invoice_id
    transaction = @transaction_repo.find_all_by_invoice_id(3)
    assert_equal 2, transaction.size
  end

  def test_find_all_by_invoice_id_returns_empty_array
    empty_transactions = @transaction_repo.find_all_by_invoice_id("-2")
    assert_equal [], empty_transactions
  end

  def test_find_by_credit_card_number
    transaction = @transaction_repo.find_by_credit_card_number('4580251236515201')
    assert_equal '4580251236515201', transaction.credit_card_number
  end

  def test_find_all_by_credit_card_number
    transactions = @transaction_repo.find_all_by_credit_card_number('4654405418249632')
    assert_equal 2, transactions.size
  end

  def test_find_by_credit_card_expiration_date
    transaction = @transaction_repo.find_by_credit_card_expiration_date('2012-03-27')
    assert_equal '2012-03-27', transaction.credit_card_expiration_date
  end

  def test_find_all_by_credit_card_expiration_date
    transactions = @transaction_repo.find_all_by_credit_card_expiration_date('')
    assert_equal 4, transactions.size
  end

  def test_find_by_result
    transaction_result = @transaction_repo.find_by_result('success')
    assert_equal 'success', transaction_result.result
  end

  def test_find_all_by_result
    transactions_results = @transaction_repo.find_all_by_result('failed')
    assert_equal 2, transactions_results.size
  end

  def test_it_loads_a_file
    load_test = TransactionRepository.new(sales_engine, './data/test/transactions.csv')
    assert_equal 25, load_test.transactions.size
  end

  def test_invoice
    sales_engine.expect(:transaction_invoice, [], [1])
    transaction_repo.invoice(1)
    sales_engine.verify
  end
end
