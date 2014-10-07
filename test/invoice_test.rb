require_relative 'test_helper'

require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  def test_invoice_attributes
    data = {
      id: '1',
      customer_id: '1',
      merchant_id: '539',
      status: '1',
      created_at: '2012-03-25 09:54:09 UTC',
      updated_at: '2012-03-25 09:54:09 UTC'
    }

    invoice = Invoice.new(data)

    assert_equal '1', invoice.id
    assert_equal '1', invoice.customer_id
    assert_equal '539', invoice.merchant_id
    assert_equal '1', invoice.status
    assert_equal '2012-03-25 09:54:09 UTC', invoice.created_at
    assert_equal '2012-03-25 09:54:09 UTC', invoice.updated_at
  end
end