require_relative 'test_helper'

require_relative '../lib/customer'
require_relative '../lib/invoice_repository'

class CustomerTest < MiniTest::Test
  attr_reader :customer, :repository

  def setup
    data = {
      id:         '1',
      first_name: 'Joey',
      last_name:  'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    @repository = Minitest::Mock.new
    @customer = Customer.new(data, repository)
  end

  def test_customer_attributes
    assert_equal 1, @customer.id
    assert_equal 'Joey', @customer.first_name
    assert_equal 'Ondricka', @customer.last_name
    assert_equal '2012-03-27 14:54:09 UTC', @customer.created_at
    assert_equal '2012-03-27 14:54:09 UTC', @customer.updated_at
  end

  # def test_invoices
  #   skip
  #   invoice_data = [
  #     {
  #     id:          '1',
  #     customer_id: '1',
  #     merchant_id: '26',
  #     status:      'shipped',
  #     created_at:  '2012-03-27 14:54:09 UTC',
  #     updated_at:  '2012-03-27 14:54:09 UTC'
  #     }
  #   ].map {|row| Invoice.new(row)}
  #
  #   invoice_repository = InvoiceRepository.new(invoice_data)
  #   @customer.set_invoice_repository(invoice_repository)
  #
  #   only_invoice = @customer.invoices.first
  #   assert_equal 1, only_invoice.id
  #   assert_equal 26, only_invoice.merchant_id
  # end
end
