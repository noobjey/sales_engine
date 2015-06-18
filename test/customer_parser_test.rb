require_relative 'test_helper'

class CustomerParserTest < Minitest::Test

  def test_the_parser_stores_the_datas_location
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    assert data_location, cp.data_location
  end

  def test_the_parser_outputs_to_an_array
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    output = cp.parse

    assert output.is_a?(Array)
  end

  def test_the_parser_outputs_customer_things
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    output = cp.parse

    assert output.first.is_a?(Customer)
  end

  def test_each_customer_is_unique
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    collection_of_customers = cp.parse

    assert_equal "2", collection_of_customers[1].id
  end

  def test_the_parser_outputs_many_things
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    output = cp.parse

    assert_equal 11, output.length
  end

  def test_the_parser_outputs_a_restructured_collection_of_customers
    data_location = "./data/fixtures/customers.csv"
    cp = CustomerParser.new(data_location)

    result = cp.parse

    assert_equal "3", result[2].id
    assert_equal 'Mariah', result[2].first_name
    assert_equal 'Toy', result[2].last_name
    assert_equal "2012-03-27 14:54:09 UTC", result[0].created_at
    assert_equal "2012-03-27 14:54:09 UTC", result[0].updated_at
  end
end
