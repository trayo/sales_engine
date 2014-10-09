require_relative 'test_helper'
require_relative '../lib/file_loader'

class FileLoaderTest < Minitest::Test
  def test_loads_a_file
    file = FileLoader.load_file("data/customers.csv")
    assert_equal "data/customers.csv", file.path
  end
end
