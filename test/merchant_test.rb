require_relative 'test_helper'

require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  attr_reader :merchant, :repository

  def setup
    data = {
      id: 1,
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    @repository = Minitest::Mock.new
    @merchant   = Merchant.new(data, repository)
  end

  def test_merchant_attributes
    assert_equal 1, merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
    assert_class = Date, merchant.created_at
    assert_class = Date, merchant.updated_at
  end

  def test_it_has_a_repository
    assert merchant.repository
  end

  def test_invoices
    repository.expect(:invoices, [], [1])
    merchant.invoices
    repository.verify
  end

  def test_items
    repository.expect(:items, [], [1])
    merchant.items
    repository.verify
  end

  def test_favorite_customer
    repository.expect(:find_favorite_customer, [], [1])
    merchant.favorite_customer
    repository.verify
  end

  def test_customers_with_pending_invoices
    repository.expect(:find_pending_customer_invoices_for_merchant, [], [1])
    merchant.customers_with_pending_invoices
    repository.verify
  end
end
