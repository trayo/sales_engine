require_relative 'invoice_item'
require_relative 'file_loader'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(engine, path)
    @engine        = engine
    @invoice_items = load(path + "/invoice_items.csv")
  end

  # def initialize(invoice_items = [])
  #   @invoice_items = invoice_items
  # end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.find {|invoice_item| invoice_item.id == id}
  end

  def find_by_item_id(item_id)
    invoice_items.find {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_by_quantity(quantity)
    invoice_items.find {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_by_unit_price(unit_price)
    invoice_items.find {|invoice_item| invoice_item.unit_price == unit_price}
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all {|invoice_item| invoice_item.unit_price == unit_price}
  end

  def load(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| InvoiceItem.new(row) }
  end

  private

  def inspect
    "#<#{self.class} #{invoice_items.size} rows>"
  end
end
