require_relative 'test_helper'

require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    merchants = [
      {
      id:         '1',
      name:       'Schroeder-Jerde',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
      },
      {
      id:         '2',
      name:       'Klein, Rempel and Jones',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '3',
      name:       'Willms and Sons',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '4',
      name:       'Cummings-Thiel',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      },
      {
      id:         '5',
      name:       'Klein, Rempel and Jones',
      created_at: '2012-03-27 14:54:10 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
      }
    ].map {|row| Merchant.new(row)}

    @merchant_repo = MerchantRepository.new(merchants)
  end

  def test_all
    assert_equal 5, @merchant_repo.all.size
  end

  def test_random
    assert_class = Merchant, @merchant_repo.random
  end

  def test_find_by_id
    merchant = @merchant_repo.find_by_id(2)
    assert_equal 2, merchant.id
  end

  def test_find_by_name
    merchant = @merchant_repo.find_by_name('Schroeder-Jerde')
    assert_equal 'Schroeder-Jerde', merchant.name
  end

  def test_find_all_by_name
    assert_equal 0, @merchant_repo.find_all_by_name('Mariah').size
  end

  def test_find_all_by_name_returns_empty_array
    empty_items = @merchant_repo.find_all_by_name('bayendor')
    assert_equal [], empty_items
  end
end
