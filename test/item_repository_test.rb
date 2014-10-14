require_relative 'test_helper'

require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :items, :item_repo, :sales_engine

  def setup
    @items = [
      {
        id:          '1',
        name:        'Item Qui Esse',
        description: 'Nihil autem sit odio inventore deleniti.',
        unit_price:  '75107',
        merchant_id: '1',
        created_at:  '2012-03-27 14:53:59 UTC',
        updated_at:  '2012-03-27 14:53:59 UTC'
      },
      {
        id:          '2',
        name:        'Item Qui Esse',
        description: 'Cumque consequuntur ad. Fuga tenetur',
        unit_price:  '67076',
        merchant_id: '1',
        created_at:  '2012-03-27 14:53:59 UTC',
        updated_at:  '2012-03-27 14:53:59 UTC'
      },
      {
        id:          '14',
        name:        'Item Itaque Consequatur',
        description: 'Voluptatibus omnis quo recusandae distinctio ',
        unit_price:  '39891',
        merchant_id: '1',
        created_at:  '2012-03-27 14:53:59 UTC',
        updated_at:  '2012-03-27 14:53:59 UTC'
      },
      {
        id:          '16',
        name:        'Item Adipisci Sint',
        description: 'Iure cumque laborum hic autem quidem voluptas.',
        unit_price:  '22951',
        merchant_id: '2',
        created_at:  '2012-03-27 14:53:59 UTC',
        updated_at:  '2012-03-27 14:53:59 UTC'
      },
      {
        id:          '17',
        name:        'Item Laudantium Ex',
        description: 'Cumque consequuntur ad. Fuga tenetur',
        unit_price:  '75107',
        merchant_id: '2',
        created_at:  '2012-03-27 14:53:59 UTC',
        updated_at:  '2012-03-27 14:53:59 UTC'
      }
    ].map {|row| Item.new(row, item_repo)}

    @sales_engine = Minitest::Mock.new
    @item_repo    = ItemRepository.new(sales_engine, items)
  end

  def test_all
    assert_equal 5, item_repo.all.size
  end

  def test_random
    assert_class = Item, item_repo.random
  end

  def test_find_by_id
    item = item_repo.find_by_id(1)
    assert_equal 1, item.id
  end

  def test_find_by_name
    item = item_repo.find_by_name('Item Itaque Consequatur')
    assert_equal 'Item Itaque Consequatur', item.name
  end

  def test_find_all_by_name
    items = item_repo.find_all_by_name("Item Qui Esse")
    assert_equal 2, items.size
  end

  def test_find_by_description
    item = item_repo.find_by_description('Iure cumque laborum hic autem quidem voluptas.')
    assert_equal 'Iure cumque laborum hic autem quidem voluptas.', item.description
  end

  def test_find_all_by_description
    items = item_repo.find_all_by_description("Cumque consequuntur ad. Fuga tenetur")
    assert_equal 2, items.size
  end

  def test_find_all_by_description_returns_empty_array
    empty_items = item_repo.find_all_by_description("elephant")
    assert_equal [], empty_items
  end

  def test_find_by_unit_price
    item = item_repo.find_by_unit_price(BigDecimal.new("229.51"))
    assert_equal BigDecimal.new("229.51"), item.unit_price
  end

  def test_find_all_by_unit_price
    items = item_repo.find_all_by_unit_price(BigDecimal.new('751.07'))
    assert_equal 2, items.size
  end

  def test_find_by_merchant_id
    item = item_repo.find_by_merchant_id(1)
    assert_equal 1, item.merchant_id
  end

  def test_find_all_by_merchant_id
    items = item_repo.find_all_by_merchant_id(1)
    assert_equal 3, items.size
  end

  def test_find_all_by_merchant_id_returns_empty_array
    empty_items = item_repo.find_all_by_merchant_id(-64)
    assert_equal [], empty_items
  end

  def test_it_loads_a_file
    load_test = ItemRepository.new(sales_engine, './data/test/items.csv')
    assert_equal 25, load_test.items.size
    item = load_test.find_by_name('Item Itaque Consequatur')
    assert_equal 'Item Itaque Consequatur', item.name
    assert_equal 14, item.id
  end

end
