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
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def customer
    repository.engine
              .customer_repository
              .find_by_id(customer_id)
  end

  def transactions
    repository.engine
              .transaction_repository
              .find_all_by_invoice_id(id)
  end

  def invoice_items
    repository.invoice_items(id)
  end

  def items
    repository.items(id)
  end
end
