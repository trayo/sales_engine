require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
  end

  def test_it_exists
    assert SalesEngine
  end

  def test_it_responds_to_startup
    assert @engine.respond_to?(:startup)
  end

  def test_it_instantiates_repositories
    @engine.startup

    handler = FileHandler.new('event_attendees.csv')
    entries = handler.entries
    repo = Repository.new(entries)
  end

end
