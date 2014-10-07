require_relative 'customer'

class CustomerRepository

  attr_reader :customers

  def initialize(customers = [])
    @customers = customers
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find {|customer| customer.id == id}
  end

  def find_by_first_name(first_name)
    customers.find {|customer| customer.first_name == first_name}
  end

  def find_by_last_name(last_name)
    customers.find {|customer| customer.last_name == last_name}
  end

  def find_all_by_first_name(first_name)
    customers.find_all {|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    customers.find_all {|customer| customer.last_name == last_name}
  end

  def random
    customers.sample
  end
end
