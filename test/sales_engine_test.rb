require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup

  end

  def test_it_exists
    assert SalesEngine
  end

  def test_it_responds_to_startup
    engine = SalesEngine.new
    assert engine.respond_to?(:startup)
  end

  def test_it_instantiates_repositories
    
  end

end
