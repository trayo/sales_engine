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
    @customer_repository     = CustomerRepository.new(self, path + "/customers.csv")
    @transaction_repository  = TransactionRepository.new(self, path + "/transactions.csv")
    @invoice_item_repository = InvoiceItemRepository.new(self, path + "/invoice_items.csv")
    @item_repository         = ItemRepository.new(self, path + "/items.csv")
    @merchant_repository     = MerchantRepository.new(self, path + "/merchants.csv")
    @invoice_repository      = InvoiceRepository.new(self, path + "/invoices.csv")
  end

  def merchant_items(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def merchant_invoices(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

end
