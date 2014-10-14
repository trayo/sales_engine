require_relative 'test_helper'

require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers, :customer_repo, :sales_engine

  def setup
    @customers = [
      {
      id:         '1',
      first_name: 'Joey',
      last_name:  'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
      },
      {
      id:         '2',
      first_name: 'Cecelia',
      last_name:  'Osinski',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '3',
      first_name: 'Mariah',
      last_name:  'Toy',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '4',
      first_name: 'Mariah',
      last_name:  'Osinski',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '5',
      first_name: 'Cecelia',
      last_name:  'Toy',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      }
    ].map {|row| Customer.new(row, customer_repo)}

    @sales_engine = Minitest::Mock.new
    @customer_repo = CustomerRepository.new(sales_engine, customers)
  end

  def test_all
    assert_equal 5, @customer_repo.all.size
  end

  def test_random
    assert_class = Customer, @customer_repo.random
  end

  def test_find_by_id
    customer = @customer_repo.find_by_id(2)
    assert_equal 2, customer.id
  end

  def test_find_by_first_name
    customer = @customer_repo.find_by_first_name('Mariah')
    assert_equal 'Mariah', customer.first_name
  end

  def test_find_all_by_first_name
    assert_equal 2, @customer_repo.find_all_by_first_name('Mariah').size
  end

  def test_find_all_by_first_name_returns_empty_array
    empty_customers = @customer_repo.find_all_by_first_name('Travis')
    assert_equal [], empty_customers
  end

  def test_find_by_last_name
    customer = @customer_repo.find_by_last_name('Toy')
    assert_equal 'Toy', customer.last_name
  end

  def test_find_all_by_last_name
    assert_equal 2, @customer_repo.find_all_by_last_name('Toy').size
  end

  def test_find_all_by_last_name_returns_empty_array
    empty_customers = @customer_repo.find_all_by_last_name('Bayendor')
    assert_equal [], empty_customers
  end

  def test_it_loads_a_file
    load_test = CustomerRepository.new(sales_engine, './data/test_customers.csv')
    assert_equal 25, load_test.customers.size
    customer = load_test.find_by_first_name('Mariah')
    assert_equal 'Mariah', customer.first_name
    assert_equal 3, customer.id
  end

  def test_transactions
    sales_engine.expect(:customer_transactions, [], [1])
    customer_repo.transactions(1)
    sales_engine.verify
  end

end
