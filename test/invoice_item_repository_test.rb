require_relative 'test_helper'

require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items, :invoice_item_repo, :sales_engine

  def setup
    @invoice_items = [
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
        item_id: "539",
        invoice_id: "15",
        quantity: "16",
        unit_price: "3024",
        created_at: '2012-03-27 14:54:13 UTC',
        updated_at: '2012-03-27 14:54:13 UTC'
      }
    ].map {|row| InvoiceItem.new(row, invoice_item_repo)}

    @sales_engine = Minitest::Mock.new
    @invoice_item_repo = InvoiceItemRepository.new(sales_engine, invoice_items)
  end

  def test_all
    assert_equal 5, @invoice_item_repo.all.size
  end

  def test_random
    assert_class = InvoiceItem, @invoice_item_repo.random
  end

  def test_find_by_id
    invoice_item = @invoice_item_repo.find_by_id(3)
    assert_equal 3, invoice_item.id
  end

  def test_find_by_item_id
    invoice_item = @invoice_item_repo.find_by_item_id(539)
    assert_equal 539, invoice_item.item_id
  end

  def test_find_all_by_item_id
    assert_equal 2, @invoice_item_repo.find_all_by_item_id(539).size
  end

  def test_find_by_invoice_id
    invoice_item = @invoice_item_repo.find_by_invoice_id(15)
    assert_equal 15, invoice_item.invoice_id
  end

  def test_find_all_by_invoice_id
    assert_equal 2, @invoice_item_repo.find_all_by_invoice_id(1).size
  end

  def test_find_by_quantity
    invoice_item = @invoice_item_repo.find_by_quantity(10)
    assert_equal 10, invoice_item.quantity
  end

  def test_find_all_by_quantity
    assert_equal 2, @invoice_item_repo.find_all_by_quantity(9).size
  end

  def test_find_by_unit_price
    invoice_item = @invoice_item_repo.find_by_unit_price(BigDecimal.new("136.35"))
    assert_equal (BigDecimal.new("136.35")), invoice_item.unit_price
  end

  def test_find_all_by_unit_price
    assert_equal 2, @invoice_item_repo.find_all_by_unit_price(BigDecimal.new("720.18")).size
  end

  def test_find_all_by_unit_price_returns_empty_array
    empty_items = @invoice_item_repo.find_all_by_unit_price("elephant")
    assert_equal [], empty_items
  end

  def test_it_loads_a_file
    load_test = InvoiceItemRepository.new(sales_engine, './data/test_invoice_items.csv')
    assert_equal 25, load_test.invoice_items.size
    invoice_items = load_test.find_by_item_id(539)
    assert_equal 539, invoice_items.item_id
    assert_equal 1, invoice_items.id
  end

end
