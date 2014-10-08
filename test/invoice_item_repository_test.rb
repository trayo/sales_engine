require_relative 'test_helper'

require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    invoice_items = [
      {
        id: "1",
        item_id: "539",
        invoice_id: "1",
        quantity: "5",
        unit_price: "13635",
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'
      },
      {
        id: "2",
        item_id: "528",
        invoice_id: "1",
        quantity: "9",
        unit_price: "23324",
        created_at: '2012-03-27 14:54:10 UTC',
        updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
        id: "3",
        item_id: "523",
        invoice_id: "2",
        quantity: "10",
        unit_price: "72018",
        created_at: '2012-03-27 14:54:11 UTC',
        updated_at: '2012-03-27 14:54:11 UTC'
      },
      {
        id: "4",
        item_id: "1832",
        invoice_id: "3",
        quantity: "9",
        unit_price: "72018",
        created_at: '2012-03-27 14:54:12 UTC',
        updated_at: '2012-03-27 14:54:12 UTC'
      },
      {
        id: "5",
        item_id: "4",
        invoice_id: "1",
        quantity: "16",
        unit_price: "3024",
        created_at: '2012-03-27 14:54:13 UTC',
        updated_at: '2012-03-27 14:54:13 UTC'
      }
    ].map {|row| InvoiceItem.new(row)}

    @invoice_item_repo = InvoiceItemRepository.new(invoice_items)
  end

  def test_all
    assert_equal 5, @invoice_item_repo.all.size
  end

  def test_random
    assert_class = InvoiceItem, @invoice_item_repo.random
  end

end
