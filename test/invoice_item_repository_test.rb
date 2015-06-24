require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items,
              :fake_sales_engine,
              :fixture_path,
              :invoice_item_input

  def setup
    @fake_sales_engine  = "fake sales engine"
    @fixture_path       = "./data/fixtures/invoice_items.csv"
    @invoice_item_input = {
      id: 1,
      item_id: 539,
      invoice_id: 1,
      quantity: 5,
      unit_price: BigDecimal.new(13635),
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC"
    }

    invoice_item1 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item2 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item3 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item4 = InvoiceItem.new(invoice_item_input, nil)

    @invoice_items = [invoice_item1, invoice_item2, invoice_item3, invoice_item4]
  end

  def test_it_knows_its_parent
    repo = InvoiceItemRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_merchants
    repo = InvoiceItemRepository.new(fake_sales_engine)

    assert [], repo.invoice_items
  end

  def test_it_loads_the_data
    repo = InvoiceItemRepository.new(fake_sales_engine)

    repo.load_data(fixture_path)

    assert_equal 10, repo.invoice_items.size
    assert_equal 10, repo.invoice_items.last.id
  end

  def test_it_finds_invoice_items_by_item_id
      repo               = InvoiceItemRepository.new(fake_sales_engine)
      item_id            = 539
      repo.invoice_items = invoice_items

      invoice_items      = repo.find_invoice_items_by_item_id(item_id)

      assert_equal 4, invoice_items.size
  end

end


