require_relative 'item'

class ItemRepository

  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def all
    items
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_customer_id(customer_id)
    find_by_attribute(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by_attribute(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by_attribute(:status, status)
  end

  def find_all_by_customer_id(customer_id)
    find_all_by_attribute(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_attribute(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all_by_attribute(:status, status)
  end

  def random
    items.sample
  end

  private

  def find_by_attribute(attribute, value)
    items.find {|item| item.public_send(attribute) == value}
  end

  def find_all_by_attribute(attribute, value)
    items.find_all {|item| item.public_send(attribute) == value}
  end

end
