require_relative 'merchant_repository'
require_relative 'customer_repository.rb'
require_relative 'invoice_repository.rb'
require_relative 'invoice_item_repository.rb'
require_relative 'item_repository.rb'
require_relative 'transaction_repository.rb'

class SalesEngine
  attr_reader :path,
              :customer_repository,
              :transaction_repository,
              :invoice_item_repository,
              :merchant_repository,
              :item_repository,
              :invoice_repository

  def initialize(path = './data')
    @path = path
  end

  def startup
    @customer_repository     = CustomerRepository.new(self, path + '/customers.csv')
    @transaction_repository  = TransactionRepository.new(self, path + '/transactions.csv')
    @invoice_item_repository = InvoiceItemRepository.new(self, path + '/invoice_items.csv')
    @item_repository         = ItemRepository.new(self, path + '/items.csv')
    @merchant_repository     = MerchantRepository.new(self, path + '/merchants.csv')
    @invoice_repository      = InvoiceRepository.new(self, path + '/invoices.csv')
  end

  def merchant_items(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def merchant_invoices(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def invoice_item_item(item_id)
    item_repository.find_by_id(item_id)
  end

  def invoice_item_invoice(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def item_invoice_items(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def item_merchant(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def invoice_transactions(id_from_invoice)
    transaction_repository.find_all_by_invoice_id(id_from_invoice)
  end

  def invoice_customer(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def find_invoice_items_for_invoice(id_from_invoice)
    invoice_item_repository.find_all_by_invoice_id(id_from_invoice)
  end

  def items_from_invoice_items(id_from_invoice)
    invoice_item_set = find_invoice_items_for_invoice(id_from_invoice)
    item_set = invoice_item_set.map(&:item_id)
    item_set.map { |item_num| item_repository.find_by_id(item_num) }
  end

  def customer_invoices(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def transaction_invoice(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def customer_transactions(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  def most_items_for_items(top_x)
    total = invoice_item_repository.total_quantity
    total[0...top_x].map { |item_id, _quantity| item_repository.find_by_id(item_id) }
  end

  def most_revenue_for_items(top_x)
    total = invoice_item_repository.total_revenue
    total[0...top_x].map { |item_id, _revenue_total| item_repository.find_by_id(item_id) }
  end

  def find_favorite_merchant_of(customer_id)
    merchant_id = grouped_merchants_for(customer_id).max_by { |_merchant_id, invoices| invoices.count }.first
    merchant_repository.find_by_id(merchant_id)
  end

  def find_favorite_customer_of(merchant_id)
    customer_id = grouped_customers_for(merchant_id).max_by { |_customer_id, invoices | invoices.count }.first
    customer_repository.find_by_id(customer_id)
  end

  # def find_pending_customer_invoices_for_merchant(merchant_id)
  #   invoices = invoice_repository.find_all_by_merchant_id(merchant_id)
  #   failed_invoices = invoices.select { |invoice| invoice.failed? }
  #   failed_invoices.map(&:customer).uniq
  # end

  private

  def find_successful_invoices(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
                      .reject(&:failed?)
  end

  def grouped_merchants_for(customer_id)
    find_successful_invoices(customer_id).group_by(&:merchant_id)
  end

  def grouped_customers_for(merchant_id)
    find_successful_merchant_invoices(merchant_id).group_by(&:customer_id)
  end

  def find_successful_merchant_invoices(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
                      .reject(&:failed?)
  end
end
