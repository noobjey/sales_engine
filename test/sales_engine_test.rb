require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_a_merchant_repository
    engine = SalesEngine.new

    engine.startup

    assert engine.merchant_repository.is_a?(MerchantRepository), "is a: #{engine.merchant_repository.class}"
  end
  def test_acceptance_merchant
    # skip
    engine = SalesEngine.new

    engine.startup

    assert_equal 'joe', engine.merchant_repository.merchants.first.name
  end
end
