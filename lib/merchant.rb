class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = repository
  end

  def items
    repository.items(id)
  end

  def invoices
    repository.invoices(id)
  end

  def revenue(date=nil)
    if date
      sum_all(invoices.select { |invoice| invoice.created_at == date })
    else
      sum_all(invoices)
    end
  end

  def sum_all(invoices)
    invoices.map do |invoice|
      if invoice.valid_transactions.empty?
        0
      else
        invoice.invoice_items_total
      end
    end.reduce(0, :+)
  end

  def favorite_customer
    repository.find_favorite_customer(id)
  end

  def customers_with_pending_invoices
    repository.find_pending_customer_invoices_for_merchant(id)
  end
end
