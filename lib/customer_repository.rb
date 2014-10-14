

require_relative 'customer'
require_relative 'file_loader'

class CustomerRepository
  attr_reader :customers, :engine

  def initialize(engine, customers)
    @engine    = engine
    @customers = customers.class == Array ? customers : load_file(customers)
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    customers.find { |customer| customer.first_name.downcase == first_name.downcase }
  end

  def find_all_by_first_name(first_name)
    customers.find_all { |customer| customer.first_name.downcase == first_name.downcase }
  end

  def find_by_last_name(last_name)
    customers.find { |customer| customer.last_name.downcase == last_name.downcase }
  end

  def find_all_by_last_name(last_name)
    customers.find_all { |customer| customer.last_name.downcase == last_name.downcase }
  end

  def invoices(id)
    engine.customer_invoices(id)
  end

  def transactions(customer_id)
    engine.customer_transactions(customer_id)
  end

  private

  def inspect
    "#<#{self.class} #{customers.size} rows>"
  end

  def load_file(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| Customer.new(row, self) }
  end
end
