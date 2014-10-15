require_relative 'invoice_item'
require_relative 'file_loader'

class InvoiceItemRepository
  attr_reader :invoice_items, :engine

  def initialize(engine, invoice_items = '')
    @engine        = engine
    invoice_items.class == Array ? @invoice_items = invoice_items : @invoice_items = load_file(invoice_items)
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    invoice_items.find { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    invoice_items.find { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def item(item_id)
    engine.invoice_item_item(item_id)
  end

  def invoice(id_from_invoice)
    engine.invoice_item_invoice(id_from_invoice)
  end

  def total_quantity
    item_ids_to_iis = successful_invoice_items.group_by { |ii| ii.item_id }
    item_id_to_quantity = item_ids_to_iis.each_with_object({}) do |(item_id, iis), quantities|
      quantities[item_id] = iis.map(&:quantity).reduce(0, :+)
    end
    item_id_to_quantity.sort_by {|item_id, quantity| -quantity}
  end

  def total_revenue
    items = successful_invoice_items.group_by { |ii| ii.item_id}
    revenue_total = items.keys.map do |item_id|
      items[item_id].map { |item| item.unit_price }.reduce(0, :+)
    end
    items.keys.zip(revenue_total).sort_by {|item_id, unit_price| unit_price}.reverse
  end

  private

  def inspect
    "#<#{self.class} #{invoice_items.size} rows>"
  end

  def load_file(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| InvoiceItem.new(row, self) }
  end

  def successful_invoice_items
    invoice_items.reject do |item|
      item.failed?
    end
  end
end

  def total_quantity_by_invoice(invoice)
    # invoices = successful_invoice_items.group_by { |ii| ii.invoice_id}
    quantities = invoices.keys.map do |invoice_id|
      invoices[invoice_id].map { |item| item.quantity }.reduce(0, :+)
    end
    invoices.keys.zip(quantities).sort_by {|invoice_id, quantity| quantity}.reverse
  end
