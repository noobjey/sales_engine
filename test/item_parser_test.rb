require_relative 'test_helper'

class ItemParserTest < Minitest::Test
  def test_the_parser_stores_the_datas_location
    data_location = "./data/fixtures/items.csv"
    mp = ItemParser.new(data_location)

    assert data_location, mp.data_location
  end

  def test_the_parser_outputs_to_an_array
    data_location = "./data/fixtures/items.csv"
    ip = ItemParser.new(data_location)

    output = ip.parse

    assert output.is_a?(Array)
  end

  def test_the_parser_outputs_item_things
    data_location = "./data/fixtures/items.csv"
    ip = ItemParser.new(data_location)

    output = ip.parse

    assert output.first.is_a?(Item)
  end

  def test_each_item_is_unique
    data_location = "./data/fixtures/items.csv"
    ip = ItemParser.new(data_location)

    collection_of_items = ip.parse

    assert_equal "2", collection_of_items[1].id
  end

  def test_the_parser_outputs_many_things
    data_location = "./data/fixtures/items.csv"
    ip = ItemParser.new(data_location)

    output = ip.parse

    assert_equal 10, output.length
  end

  def test_the_parser_outputs_a_restructured_collection_of_items
    data_location = "./data/fixtures/items.csv"
    ip = ItemParser.new(data_location)

    result = ip.parse

    assert_equal "3", result[2].id
    assert_equal 'Item Ea Voluptatum', result[2].name
    assert_equal "2012-03-27 14:53:59 UTC", result[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", result[0].updated_at
  end
end
