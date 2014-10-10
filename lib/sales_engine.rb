require 'csv'
require_relative 'file_loader.rb'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer.rb'
require_relative 'customer_repository.rb'
require_relative 'invoice.rb'
require_relative 'invoice_repository.rb'
require_relative 'invoice_item.rb'
require_relative 'invoice_item_repository.rb'
require_relative 'item.rb'
require_relative 'item_repository.rb'
require_relative 'transaction.rb'
require_relative 'transaction_repository.rb'

class SalesEngine
  attr_reader :path,
              :customer_repository,
              :transaction_repository,
              :invoice_item_repository

  def initialize(path = './data/')
    @path = path
  end

  def startup
    @customer_repository = CustomerRepository.new(self, path)
    @transaction_repository = TransactionRepository.new(self, path)
    @invoice_item_repository = InvoiceItemRepository.new(self, path)
  end
end
