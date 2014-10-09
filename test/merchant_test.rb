require_relative 'test_helper'

require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test

  def setup
    data = {
      id: 1,
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    @merchant = Merchant.new(data)
  end

  def test_merchant_attributes
    assert_equal 1, @merchant.id
    assert_equal 'Schroeder-Jerde'.downcase, @merchant.name
    assert_equal '2012-03-27 14:53:59 UTC', @merchant.created_at
    assert_equal '2012-03-27 14:53:59 UTC', @merchant.updated_at
  end
end
