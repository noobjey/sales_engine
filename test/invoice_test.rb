require_relative 'test_helper'
require_relative '../lib/invoice'

class ItemTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id:          "1",
      customer_id: "1",
      merchant_id: "26",
      status:      "shipped",
      created_at:  "2012-03-25 09:54:09 UTC",
      updated_at:  "2012-03-25 09:54:09 UTC"
    }
  end

  def test_it_has_an_id
    assert_equal data[:id].to_i, Invoice.new(data, nil).id
  end

  def test_it_has_a_customer_id
    assert_equal data[:customer_id].to_i, Invoice.new(data, nil).customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal data[:merchant_id].to_i, Invoice.new(data, nil).merchant_id
  end

  def test_it_has_a_status
    assert_equal data[:status], Invoice.new(data, nil).status
  end

  def test_it_has_a_created_at_date
    assert_equal Date.parse(data[:created_at]), Invoice.new(data, nil).created_at
  end

  def test_it_has_an_updated_at_date
    assert_equal Date.parse(data[:updated_at]), Invoice.new(data, nil).updated_at
  end

  def test_it_belongs_to_a_repository
    repository = 'fake repository'
    assert_equal repository, Invoice.new(data, repository).repository
  end

  def test_it_has_transactions
    repo    = Minitest::Mock.new
    invoice = Invoice.new(data, repo)

    repo.expect(:find_transactions_by_id, nil, [data[:id].to_i])
    invoice.transactions

    repo.verify
  end

  def test_it_has_a_customer
    repo    = Minitest::Mock.new
    invoice = Invoice.new(data, repo)

    repo.expect(:find_customer_by_customer_id, nil, [data[:customer_id].to_i])
    invoice.customer

    repo.verify
  end

  # issue with test runner so added an ss to end so it would run the test
  def test_it_has_invoice_itemss
    repo    = Minitest::Mock.new
    invoice = Invoice.new(data, repo)

    repo.expect(:find_invoice_items_by_id, nil, [data[:id].to_i])
    invoice.invoice_items

    repo.verify
  end

  def test_it_has_items
    repo    = Minitest::Mock.new
    invoice = Invoice.new(data, repo)

    repo.expect(:find_items, nil, [data[:id].to_i])
    invoice.items

    repo.verify
  end

  def test_charge_creates_a_transaction
    repo        = Minitest::Mock.new
    invoice     = Invoice.new(data, repo)
    information = {
      credit_card_number:          '1111222233334444',
      credit_card_expiration_date: "10/14",
      result:                      "success",
      invoice_id:                  data[:id]
    }

    repo.expect(:create_transaction_by_id, nil, [information, invoice.id])
    invoice.charge(information)

    repo.verify
  end

end
