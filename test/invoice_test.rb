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
    assert_equal data[:created_at], Invoice.new(data, nil).created_at
  end

  def test_it_has_an_updated_at_date
    assert_equal data[:updated_at], Invoice.new(data, nil).updated_at
  end

  def test_it_belongs_to_a_repository
    repository = 'fake repository'
    assert_equal repository, Invoice.new(data, repository).repository
  end
end