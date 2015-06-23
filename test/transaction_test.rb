require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :data

  # id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
  # 1,1,4654405418249632,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC

  def setup
    @data = {
      id:                          "1",
      invoice_id:                  "1",
      credit_card_number:          "4654405418249632",
      credit_card_expiration_date: "",
      result:                      "success",
      created_at:                  "2012-03-27 14:54:09 UTC",
      updated_at:                  "2012-03-27 14:54:09 UTC"
    }
  end

  def test_it_has_an_id
    assert_equal data[:id].to_i, Transaction.new(data, nil).id
  end

  def test_it_has_an_invoice_id
    assert_equal data[:invoice_id].to_i, Transaction.new(data, nil).invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal data[:credit_card_number], Transaction.new(data, nil).credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal data[:credit_card_expiration_date], Transaction.new(data, nil).credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal data[:result], Transaction.new(data, nil).result
  end

  def test_it_has_a_created_at_date
    assert_equal data[:created_at], Transaction.new(data, nil).created_at
  end

  def test_it_has_a_updated_at_date
    assert_equal data[:updated_at], Transaction.new(data, nil).updated_at
  end

  def test_it_belongs_to_a_repository
    repository = 'fake repository'
    assert_equal repository, Transaction.new(data, repository).repository
  end

end
