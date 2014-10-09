require_relative 'customer'
require_relative 'file_loader'

class CustomerRepository

  attr_reader :customers

  def initialize(engine, path)
    @engine    = engine
    @customers = load(path + "/customers.csv")
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.find {|customer| customer.id == id}
  end

  def find_by_first_name(first_name)
    customers.find {|customer| customer.first_name == first_name.downcase}
  end

  def find_all_by_first_name(first_name)
    customers.find_all {|customer| customer.first_name == first_name.downcase}
  end

  def find_by_last_name(last_name)
    customers.find {|customer| customer.last_name == last_name.downcase}
  end

  def find_all_by_last_name(last_name)
    customers.find_all {|customer| customer.last_name == last_name.downcase}
  end

  def inspect
    "#<#{self.class} #{customers.size} rows>"
  end

  def load(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| Customer.new(row) }
  end
end
