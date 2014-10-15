class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = repository
  end

  def invoices
    repository.invoices(id)
  end

  def transactions
    repository.transactions(id)
  end

  def favorite_merchant
    repository.find_favorite_merchant(id)
  end
end
