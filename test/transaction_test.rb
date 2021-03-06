require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id:                          "2",
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
    assert_equal Date.parse(data[:created_at]), Transaction.new(data, nil).created_at
  end

  def test_it_has_a_updated_at_date
    assert_equal Date.parse(data[:updated_at]), Transaction.new(data, nil).updated_at
  end

  def test_it_belongs_to_a_repository
    repository = 'fake repository'
    assert_equal repository, Transaction.new(data, repository).repository
  end

  def test_it_has_an_invoice
    repo = Minitest::Mock.new
    transaction = Transaction.new(data, repo)

    repo.expect(:find_invoice_by_invoice_id, nil, [data[:invoice_id].to_i])
    transaction.invoice

    repo.verify
  end
end
