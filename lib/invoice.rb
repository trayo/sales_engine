class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository  = repository
  end

  def customer
    repository.customer(customer_id)
  end

  def transactions
    repository.transactions(id)
  end

  def invoice_items
    repository.invoice_items(id)
  end

  def items
    repository.items(id)
  end

  def invoice_items_total
    invoice_items.reduce(0) { |sum, item| sum + item.total }
  end

  def failed?
    transactions.any? { |transaction| transaction.failed? }
  end

  def valid_transactions
    transactions.reject { |transaction| transaction.failed? }
  end
end
