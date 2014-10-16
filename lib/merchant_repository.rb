require_relative 'merchant'
require_relative 'file_loader'

class MerchantRepository
  attr_reader :merchants, :engine

  def initialize(engine, merchants = '')
    @engine = engine
    merchants.class == Array ? @merchants = merchants : @merchants = load_file(merchants)
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name.downcase == name.downcase }
  end

  def items(id)
    engine.merchant_items(id)
  end

  def invoices(id)
    engine.merchant_invoices(id)
  end

  def revenue(date)
    merchants.reduce(0) { |sum, merchant| sum + merchant.revenue(date) }
  end

  def most_items(top_x)
    engine.most_items_for_merchant(top_x)
  end

  def find_favorite_customer(merchant_id)
    engine.find_favorite_customer_of(merchant_id)
  end

  def find_pending_customer_invoices_for_merchant(merchant_id)
    invoices = engine.invoice_repository.find_all_by_merchant_id(merchant_id)
    failed_invoices = invoices.select(&:failed?)
    failed_invoices.map(&:customer).uniq
  end

  private

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end

  def load_file(filepath)
    contents = FileLoader.load_file(filepath)
    contents.map { |row| Merchant.new(row, self) }
  end
end
