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
    assert_class = DateTime, merchant.created_at
    assert_class = DateTime, merchant.updated_at
  end

  def test_it_has_a_repository
    assert merchant.repository
  end
end
