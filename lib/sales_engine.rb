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
    item_set = invoice_item_set.map {|ii| ii.item_id}
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
end
