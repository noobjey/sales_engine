require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_a_merchant_repository
    data_location = "./data/fixtures/merchants.csv"
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert engine.merchant_repository.is_a?(MerchantRepository), "is a: #{engine.merchant_repository.class}"
  end

  def test_default_location_for_merchant_data
    engine   = SalesEngine.new
    expected = "./data/merchants.csv"

    engine.startup

    assert_equal expected, engine.merchant_data_location
  end

  def test_can_override_default_data_location
    engine   = SalesEngine.new('different location')
    expected = 'different location'

    assert_equal expected, engine.merchant_data_location
  end

  def test_acceptance_merchant
    data_location = "./data/fixtures/merchants.csv"
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert_equal 'Schroeder-Jerde', engine.merchant_repository.merchants.first.name
    assert_equal 'Klein, Rempel and Jones', engine.merchant_repository.merchants[1].name
  end
end
