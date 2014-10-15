def find_favorite_merchant_of(customer_id)
  # find all invoices from customer
  invoices = invoice_repository.find_all_by_customer_id(customer_id)
  # select only successful invoices
  successful_invoices = invoices.select { |invoice| invoice.successful? }
  # group those invoices by merchant id
  grouped_by_merchant = successful_invoices.group_by { |invoice| invoice.merchant_id }
  # select the merchant id that has the most invoices
  merchant_id = grouped_by_merchant.max_by { |merchant_id, invoices| invoices.count }.first
  # find that merchant instance by its id
  merchant_repository.find_by_id(merchant_id)
end