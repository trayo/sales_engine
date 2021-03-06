require_relative 'test_helper'

require_relative '../lib/item'

class ItemTest < MiniTest::Test
  attr_reader :item, :repository

  def setup
    data = {
      id:          '1',
      name:        'Item Qui Esse',
      description: 'Nihil autem sit odio inventore deleniti.',
      unit_price:  '75107',
      merchant_id: '1',
      created_at:  '2012-03-27 14:53:59 UTC',
      updated_at:  '2012-03-27 14:53:59 UTC'
    }
    @repository = Minitest::Mock.new
    @item = Item.new(data, repository)
  end

  def test_item_attributes
    assert_equal 1, item.id
    assert_equal 'Item Qui Esse', item.name
    assert_equal 'Nihil autem sit odio inventore deleniti.', item.description
    assert_equal BigDecimal.new('751.07'), item.unit_price
    assert_equal 1, item.merchant_id
    assert_class = Date, item.created_at
    assert_class = Date, item.updated_at
  end

	def test_it_has_a_repository
		assert item.repository
	end

  def test_it_delegates_items_to_repository
    repository.expect(:invoice_items, [], [1])
    item.invoice_items
    repository.verify
  end

  def test_it_delegates_invoices_to_repository
    repository.expect(:merchant, [], [1])
    item.merchant
    repository.verify
  end
end
