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
      }
    ].map {|row| Customer.new(row)}

    @customer_repo = CustomerRepository.new(customers)
  end

  def test_find_all
    assert_equal 3, @customer_repo.all.size
  end

  def test_find_by_id
    customer = @customer_repo.find_by_id(2)
    assert_equal 2, customer.id
  end

end

#all returns all instances

#random returns a random instance

#find_by_X(match), where X is some attribute, returns a single instance whose X attribute

#find_all_by_X(match) works just like find_by_X
#If there is no match, it returns an empty Array.
