require_relative 'test_helper'

require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    customers = [
      {
      id: '1',
      first_name: 'Joey',
      last_name: 'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
      },
      {
      id: '2',
      first_name: 'Cecelia',
      last_name: 'Osinski',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id: '3',
      first_name: 'Mariah',
      last_name: 'Toy',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id: '4',
      first_name: 'Mariah',
      last_name: 'Osinski',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id: '5',
      first_name: 'Cecelia',
      last_name: 'Toy',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      }
    ].map {|row| Customer.new(row)}

    @customer_repo = CustomerRepository.new(customers)
  end

  def test_find_all
    assert_equal 5, @customer_repo.all.size
  end

  def test_find_by_id
    customer = @customer_repo.find_by_id(2)
    assert_equal 2, customer.id
  end

  def test_find_by_first_name
    customer = @customer_repo.find_by_first_name('Mariah')
    assert_equal 'Mariah', customer.first_name
  end

  def test_find_by_last_name
    customer = @customer_repo.find_by_last_name('Toy')
    assert_equal 'Toy', customer.last_name
  end

  def test_find_all_by_first_name
    assert_equal 2, @customer_repo.find_all_by_first_name('Mariah').size
  end

  def test_find_all_by_last_name
    assert_equal 2, @customer_repo.find_all_by_last_name('Toy').size
  end

  def test_find_random
    assert_class = Customer, @customer_repo.random
  end
end

#If there is no match, it returns an empty Array.