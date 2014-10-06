require_relative 'test_helper'

require_relative '../lib/entry'

class EntryTest < MiniTest::Test
  def test_entry_attributes
    data = {
      regdate: '11/12/08 10:47',
      first_name: 'Allison',
      last_name: 'Nguyen',
      email_address: 'arannon@jumpstartlab.com',
      homephone: '6154385000', Street: '3155 19th St NW',
      city: 'Washington',
      state: 'DC',
      zipcode: '20010'
    }

    entry = Entry.new(data)

    assert_equal 'Allison', entry.first_name
    assert_equal 'Nguyen', entry.last_name
    assert_equal 'Allison Nguyen', entry.name
    assert_equal '6154385000', entry.phone_number
    assert_equal 'DC', entry.state
    assert_equal '20010', entry.zipcode
  end
end