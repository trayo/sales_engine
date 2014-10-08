require_relative 'item'

class ItemRepository

  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def find_by_description(description)
    find_by_attribute(:description, description)
  end

  def find_all_by_description(description)
    find_all_by_attribute(:description, description)
  end

  def find_by_unit_price(unit_price)
    find_by_attribute(:unit_price, unit_price)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_attribute(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by_attribute(:merchant_id, merchant_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_attribute(:merchant_id, merchant_id)
  end

  private

  def find_by_attribute(attribute, value)
    items.find {|item| item.public_send(attribute) == value}
  end

  def find_all_by_attribute(attribute, value)
    items.find_all {|item| item.public_send(attribute) == value}
  end

end
