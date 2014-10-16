require_relative 'invoice'
require_relative 'file_loader'

class InvoiceRepository
  attr_reader :invoices, :engine

  def initialize(engine, invoices = '')
    @engine = engine
    invoices.class == Array ? @invoices = invoices :
      @invoices = load_file(invoices)
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    invoices.find { |invoice| invoice.status == status }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status == status }
  end

  def transactions(id_from_invoice)
    engine.invoice_transactions(id_from_invoice)
  end

  def customer(customer_id)
    engine.invoice_customer(customer_id)
  end

  def invoice_items(id_from_invoice)
    engine.find_invoice_items_for_invoice(id_from_invoice)
  end

  def items(id_from_invoice)
    engine.items_from_invoice_items(id_from_invoice)
  end

  private

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end

  def load_file(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| Invoice.new(row, self) }
  end
end
