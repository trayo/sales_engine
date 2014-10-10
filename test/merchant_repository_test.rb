require_relative 'test_helper'

require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants, :merchant_repo, :sales_engine

  def setup
    @merchants = [
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
    ].map {|row| Merchant.new(row, merchant_repo)}

    @sales_engine  = Minitest::Mock.new
    @merchant_repo = MerchantRepository.new(sales_engine, merchants)
  end

  def test_all
    assert_equal 5, merchant_repo.all.size
  end

  def test_random
    assert_class = Merchant, merchant_repo.random
  end

  def test_find_by_id
    merchant = merchant_repo.find_by_id(2)
    assert_equal 2, merchant.id
  end

  def test_find_by_name
    merchant = merchant_repo.find_by_name('Schroeder-Jerde')
    assert_equal 'Schroeder-Jerde', merchant.name
  end

  def test_find_all_by_name
    assert_equal 2, merchant_repo.find_all_by_name('Klein, Rempel and Jones').size
  end

  def test_find_all_by_name_returns_empty_array
    empty_items = merchant_repo.find_all_by_name('bayendor')
    assert_equal [], empty_items
  end

  def test_it_loads_a_file
    load_test = MerchantRepository.new(sales_engine, './data/test_merchants.csv')
    assert_equal 25, load_test.merchants.size
    merchant = load_test.find_by_name('Williamson Group')
    assert_equal 'Williamson Group', merchant.name
    assert_equal 5, merchant.id
  end
end
