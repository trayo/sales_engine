class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id].to_i
    @first_name = data[:first_name].downcase
    @last_name  = data[:last_name].downcase
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def set_invoice_repository(invoice_repository)
    @invoice_repository = invoice_repository
  end

  def invoices
    @invoice_repository.find_all_by_customer_id(id)
  end
end
