require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it
    assert !!SalesEngine.new
  end
end
