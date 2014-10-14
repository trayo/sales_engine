require_relative 'test_helper'

require_relative '../lib/customer'
require_relative '../lib/invoice_repository'

class CustomerTest < MiniTest::Test
  attr_reader :customers, :customer, :repository

  def setup
    @customers = {
      id:         '1',
      first_name: 'Joey',
      last_name:  'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    @repository = Minitest::Mock.new
    @customer = Customer.new(customers, repository)
  end

  def test_customer_attributes
    assert_equal 1, customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
    assert_class = DateTime, customer.created_at
    assert_class = DateTime, customer.updated_at
  end

  def test_transactions
    repository.expect(:transactions, [], [1])
    customer.transactions
    repository.verify
  end
end
