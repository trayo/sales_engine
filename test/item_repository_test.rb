require_relative 'test_helper'

require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    items = [
      {
        id: '1',
        name: 'Item Qui Esse',
        description: 'Nihil autem sit odio inventore deleniti.',
        unit_price: '75107',
        merchant_id: '1',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      },
      {
        id: '2',
        name: 'Item Autem Minima',
        description: 'Cumque consequuntur ad. Fuga tenetur',
        unit_price: '67076',
        merchant_id: '1',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      },
      {
        id: '14',
        name: 'Item Itaque Consequatur',
        description: 'Voluptatibus omnis quo recusandae distinctio ',
        unit_price: '39891',
        merchant_id: '1',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      },
      {
        id: '16',
        name: 'Item Adipisci Sint',
        description: 'Iure cumque laborum hic autem quidem voluptas.',
        unit_price: '22951',
        merchant_id: '2',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      },
      {
        id: '17',
        name: 'Item Laudantium Ex',
        description: 'In dolor architecto doloribus omnis fuga.',
        unit_price: '60713',
        merchant_id: '2',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      }
    ].map {|row| Item.new(row)}

    @item_repo = ItemRepository.new(items)
  end

  def test_all
    assert_equal 5, @item_repo.all.size
  end

  def test_random
    assert_class = Item, @item_repo.random
  end

  def test_find_by_id
    item = @item_repo.find_by_id(1)
    assert_equal 4, item.id
  end

  def test_find_by_customer_id
    skip
    item = @item_repo.find_by_customer_id(2)
    assert_equal 2, item.customer_id
  end

  def test_find_by_merchant_id
    skip
    item = @item_repo.find_by_merchant_id(86)
    assert_equal 86, item.merchant_id
  end

  def test_find_by_status
    skip
    item = @item_repo.find_by_status("canceled")
    assert_equal "canceled", item.status
  end

  def test_find_all_by_customer_id
    skip
    items = @item_repo.find_all_by_customer_id(1)
    assert_equal 2, items.size
  end

  def test_find_all_by_customer_id_returns_empty_array
    skip
    empty_items = @item_repo.find_all_by_customer_id(-64)
    assert_equal [], empty_items
  end

  def test_find_all_by_merchant_id
    skip
    items = @item_repo.find_all_by_merchant_id(44)
    assert_equal 2, items.size
  end

  def test_find_all_by_merchant_id_returns_empty_array
    skip
    empty_items = @item_repo.find_all_by_merchant_id(-64)
    assert_equal [], empty_items
  end

  def test_find_all_by_status
    skip
    items = @item_repo.find_all_by_status("shipped")
    assert_equal 4, items.size
  end

  def test_find_all_by_status_returns_empty_array
    skip
    empty_items = @item_repo.find_all_by_status("elephant")
    assert_equal [], empty_items
  end

end
