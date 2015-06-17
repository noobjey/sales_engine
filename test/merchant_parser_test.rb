require_relative 'test_helper'

class MerchantParserTest < Minitest::Test
  def test_the_parser_stores_the_datas_location
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    assert data_location, mp.data_location
  end

  def test_the_parser_outputs_to_an_array
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    output = mp.parse

    assert output.is_a?(Array)
  end

  def test_the_parser_outputs_merchant_things
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    output = mp.parse

    assert output.first.is_a?(Merchant)
  end

  def test_each_merchant_is_unique
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    collection_of_merchants = mp.parse

    assert_equal "2", collection_of_merchants[1].id
  end

  def test_the_parser_outputs_many_things
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    output = mp.parse

    assert_equal 4, output.length
  end

  def test_the_parser_outputs_a_restructured_collection_of_merchants
    skip
    data_location = "./data/fixtures/merchants.csv"
    mp = MerchantParser.new(data_location)

    result = mp.parse
    # id
    # name
    # created at
    # updated at
    assert_equal 'Willms and Sons', result[2].name
    assert_equal 3, result[2].id
  #   add dates in object
  end
end
