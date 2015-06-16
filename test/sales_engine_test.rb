require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_a_merchant_repository
    engine = SalesEngine.new

    engine.startup

    assert engine.merchant_repository.is_a?(MerchantRepository), "is a: #{engine.merchant_repository.class}"
  end

  def test_passes_in_merchant_file
    engine = SalesEngine.new
    expected = 'merchant.csv'

    engine.startup

    assert_equal expected, engine.merchant_file_name
  end

  def test_acceptance_merchant
    skip
    engine = SalesEngine.new

    engine.startup

    assert_equal 'Schroeder-Jerde', engine.merchant_repository.merchants.first.name
    assert_equal 'Klein, Rempel and Jones', engine.merchant_repository.merchants[1].name
  end
end
