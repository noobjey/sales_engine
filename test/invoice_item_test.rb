require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
      id: "1",
      item_id: "539",
      invoice_id: "1",
      quantity: "5",
      unit_price: "13635",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC"
    }
  end

  def test_it_has_the_expected_initialized_id
    assert_equal data[:id].to_i, InvoiceItem.new(data, nil).id
    end

  def test_it_has_the_expected_item_id
    assert_equal data[:item_id].to_i, InvoiceItem.new(data, nil).item_id
  end

  def test_it_has_the_expected_invoice_id
    assert_equal data[:invoice_id].to_i, InvoiceItem.new(data, nil).invoice_id
  end

  def test_it_has_the_expected_quantity
    assert_equal data[:quantity].to_i, InvoiceItem.new(data, nil).quantity
  end

  def test_it_has_the_expected_unit_price
    assert_equal BigDecimal.new(data[:unit_price])/100, InvoiceItem.new(data, nil).unit_price
  end

  def test_it_has_the_expected_created_at
    assert_equal data[:created_at], InvoiceItem.new(data, nil).created_at
    end

  def test_it_has_the_expected_updated_at
    assert_equal data[:updated_at], InvoiceItem.new(data, nil).updated_at
  end

  def test_has_an_invoice
    repo     = Minitest::Mock.new
    invoice_item = InvoiceItem.new(data, repo)

    repo.expect(:find_invoice_by_id, nil, [data[:invoice_id].to_i])
    invoice_item.invoice

    repo.verify
  end

  def test_has_an_item
    repo     = Minitest::Mock.new
    invoice_item = InvoiceItem.new(data, repo)

    repo.expect(:find_item_by_id, nil, [data[:item_id].to_i])
    invoice_item.item

    repo.verify
  end
end
