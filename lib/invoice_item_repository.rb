require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(invoice_items = [])
    @invoice_items = invoice_items
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end



end
