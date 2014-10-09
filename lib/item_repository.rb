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
    items.find {|item| item.id == id}
  end

  def find_by_name(name)
    items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    items.find_all {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(description)
    items.find {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_description(description)
    items.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_by_unit_price(unit_price)
    items.find {|item| item.unit_price == unit_price}
  end

  def find_all_by_unit_price(unit_price)
    items.find_all {|item| item.unit_price == unit_price}
  end

  def find_by_merchant_id(merchant_id)
    items.find {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all {|item| item.merchant_id == merchant_id}
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

end
