class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name].downcase
    @description = data[:description].downcase
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def invoice_items
    repository.find_invoices_from(id)
  end

  def merchant
    repository.merchant_for(merchant_id)
  end
end
