require_relative 'test_helper'

require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoices, :invoice_repo, :sales_engine

  def setup
    @invoices = [
      {
      id:          '1',
      customer_id: '1',
      merchant_id: '26',
      status:      'shipped',
      created_at:  '2012-03-27 14:54:09 UTC',
      updated_at:  '2012-03-27 14:54:09 UTC'
      },
      {
      id:          '2',
      customer_id: '1',
      merchant_id: '75',
      status:      'shipped',
      created_at:  '2012-03-27 14:54:10 UTC',
      updated_at:  '2012-03-27 14:54:10 UTC'
      },
      {
      id:          '3',
      customer_id: '2',
      merchant_id: '44',
      status:      'shipped',
      created_at:  '2012-03-27 14:54:11 UTC',
      updated_at:  '2012-03-27 14:54:11 UTC'
      },
      {
      id:          '4',
      customer_id: '3',
      merchant_id: '86',
      status:      'canceled',
      created_at:  '2012-03-27 14:54:12 UTC',
      updated_at:  '2012-03-27 14:54:12 UTC'
      },
      {
      id:          '5',
      customer_id: '4',
      merchant_id: '44',
      status:      'shipped',
      created_at:  '2012-03-27 14:54:13 UTC',
      updated_at:  '2012-03-27 14:54:13 UTC'
      }
    ].map {|row| Invoice.new(row, invoice_repo)}

    @sales_engine = Minitest::Mock.new
    @invoice_repo = InvoiceRepository.new(sales_engine, invoices)
  end

  def test_all
    assert_equal 5, invoice_repo.all.size
  end

  def test_random
    assert_class = Invoice, invoice_repo.random
  end

  def test_find_by_id
    invoice = invoice_repo.find_by_id(4)
    assert_equal 4, invoice.id
  end

  def test_find_by_customer_id
    invoice = invoice_repo.find_by_customer_id(2)
    assert_equal 2, invoice.customer_id
  end

  def test_find_all_by_customer_id
    invoices = invoice_repo.find_all_by_customer_id(1)
    assert_equal 2, invoices.size
  end

  def test_find_all_by_customer_id_returns_empty_array
    empty_invoices = invoice_repo.find_all_by_customer_id(-64)
    assert_equal [], empty_invoices
  end

  def test_find_by_merchant_id
    invoice = invoice_repo.find_by_merchant_id(86)
    assert_equal 86, invoice.merchant_id
  end

  def test_find_all_by_merchant_id
    invoices = invoice_repo.find_all_by_merchant_id(44)
    assert_equal 2, invoices.size
  end

  def test_find_all_by_merchant_id_returns_empty_array
    empty_invoices = invoice_repo.find_all_by_merchant_id(-64)
    assert_equal [], empty_invoices
  end

  def test_find_by_status
    invoice = invoice_repo.find_by_status("canceled")
    assert_equal "canceled", invoice.status
  end

  def test_find_all_by_status
    invoices = invoice_repo.find_all_by_status("shipped")
    assert_equal 4, invoices.size
  end

  def test_find_all_by_status_returns_empty_array
    empty_invoices = invoice_repo.find_all_by_status("elephant")
    assert_equal [], empty_invoices
  end

  def test_it_loads_a_file
    load_test = InvoiceRepository.new(sales_engine, './data/test/invoices.csv')
    assert_equal 25, load_test.invoices.size
    invoice = load_test.find_by_customer_id(4)
    assert_equal 44, invoice.merchant_id
    assert_equal 4, invoice.customer_id
  end

  def test_items
    sales_engine.expect(:items_from_invoice_items, [], [1])
    invoice_repo.items(1)
    sales_engine.verify
  end

  def test_customer
    sales_engine.expect(:invoice_customer, [], [1])
    invoice_repo.customer(1)
    sales_engine.verify
  end

  def test_transactions
    sales_engine.expect(:invoice_transactions, [], [1])
    invoice_repo.transactions(1)
    sales_engine.verify
  end

  def test_invoice_items
    sales_engine.expect(:find_invoice_items_for_invoice, [], [1])
    invoice_repo.invoice_items(1)
    sales_engine.verify
  end

end
