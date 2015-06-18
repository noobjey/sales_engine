require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_a_merchant_repository
    data_location = {merchant: "./data/fixtures/merchants.csv", item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert engine.merchant_repository.is_a?(MerchantRepository)
  end

  def test_it_has_a_merchant_parser
    data_location = {merchant: "./data/fixtures/merchants.csv"}
    engine        = SalesEngine.new(data_location)

    assert engine.merchant_parser.is_a?(MerchantParser)
    assert_equal "./data/fixtures/merchants.csv", engine.merchant_parser.data_location
  end

  def test_default_location_for_merchant_data
    engine   = SalesEngine.new
    expected = "./data/merchants.csv"

    engine.startup

    assert_equal expected, engine.merchant_data_location
  end

  def test_can_override_default_data_location
    engine   = SalesEngine.new({merchant: 'different location'})
    expected = 'different location'

    assert_equal expected, engine.merchant_data_location
  end

  def test_it_passes_parsed_merchant_data_to_merchant_repository
    data_location = {merchant: "./data/fixtures/merchants.csv", item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert_equal 4, engine.merchant_repository.merchants.length
    assert_equal 'Willms and Sons', engine.merchant_repository.merchants[2].name
  end

  def test_it_has_an_item_repository
    engine        = SalesEngine.new

    engine.startup

    assert engine.item_repository.is_a?(ItemRepository)
  end

  def test_it_has_an_item_parser
    data_location = {item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    assert engine.item_parser.is_a?(ItemParser)
    assert_equal "./data/fixtures/items.csv", engine.item_parser.data_location
  end

  def test_it_passes_the_correct_data_location_to_each_parser
    item_data_location = "./data/fixtures/items.csv"
    merchant_data_location = "./data/fixtures/merchants.csv"
    dataset_locations = {merchant: merchant_data_location, item: item_data_location }
    engine        = SalesEngine.new(dataset_locations)

    assert_equal item_data_location, engine.item_parser.data_location
    assert_equal merchant_data_location, engine.merchant_parser.data_location
  end

  def test_it_has_a_default_item_location
    engine   = SalesEngine.new
    expected = "./data/items.csv"

    engine.startup

    assert_equal expected, engine.item_data_location
  end

  def test_it_passes_parsed_item_data_to_item_repository
    data_location = {merchant: "./data/fixtures/merchants.csv", item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert_equal 10, engine.item_repository.items.length
    assert_equal '31163', engine.item_repository.items[6].unit_price
  end

  def test_acceptance_merchant
    # skip
    data_location = {merchant: "./data/fixtures/merchants.csv", item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert_equal 'Schroeder-Jerde', engine.merchant_repository.merchants.first.name
    assert_equal 'Klein, Rempel and Jones', engine.merchant_repository.merchants[1].name
  end

  def test_acceptance_item
    # skip
    data_location = {merchant: "./data/merchants.csv", item: "./data/fixtures/items.csv"}
    engine        = SalesEngine.new(data_location)

    engine.startup

    assert_equal '75107', engine.item_repository.items.first.unit_price
    assert_equal 'Item Autem Minima', engine.item_repository.items[1].name
  end
end
