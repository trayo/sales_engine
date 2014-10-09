require_relative 'invoice'

class InvoiceRepository

  attr_reader :invoices

  def initialize(invoices = [])
    @invoices = invoices
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find {|item| item.id == id}
  end

  def find_by_customer_id(customer_id)
    invoices.find {|item| item.customer_id == customer_id}
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all {|item| item.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    invoices.find {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all {|item| item.merchant_id == merchant_id}
  end

  def find_by_status(status)
    invoices.find {|item| item.status == status}
  end

  def find_all_by_status(status)
    invoices.find_all {|item| item.status == status}
  end

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end
end
