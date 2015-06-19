require_relative 'test_helper'

class TransactionParserTest < Minitest::Test
  def test_the_parser_stores_the_datas_location
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    assert data_location, tp.data_location
  end

  def test_the_parser_outputs_to_an_array
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    output = tp.parse

    assert output.is_a?(Array)
  end

  def test_the_parser_outputs_transaction_things
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    output = tp.parse

    assert output.first.is_a?(Transaction)
  end

  def test_each_transaction_is_unique
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    collection_of_transactions = tp.parse

    assert_equal "2", collection_of_transactions[1].id
  end

  def test_the_parser_outputs_many_things
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    output = tp.parse

    assert_equal 10, output.length
  end

  def test_the_parser_outputs_a_restructured_collection_of_transactions
    data_location = "./data/fixtures/transactions.csv"
    tp = TransactionParser.new(data_location)

    result = tp.parse

    assert_equal "3", result[2].id
    assert_equal "4", result[2].invoice_id
    assert_equal "2012-03-27 14:54:09 UTC", result[0].created_at
    assert_equal "2012-03-27 14:54:09 UTC", result[0].updated_at
  end
end
