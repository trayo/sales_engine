require_relative 'invoice'

class InvoiceRepository

  attr_reader :invoices

  def initialize(invoices = [])
    @invoices = invoices
  end

  def all
    invoices
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
    invoices.sample
  end

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end

  private

  def find_by_attribute(attribute, value)
    invoices.find {|invoice| invoice.public_send(attribute) == value}
  end

  def find_all_by_attribute(attribute, value)
    invoices.find_all {|invoice| invoice.public_send(attribute) == value}
  end

end
