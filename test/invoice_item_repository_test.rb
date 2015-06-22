require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items

  class FakeInvoiceItem
    attr_reader :id,
                :item_id

    def initialize(id, item_id)
      @id      = id
      @item_id = item_id
    end
  end

  def setup
    invoice_item1 = FakeInvoiceItem.new(1, 2)
    invoice_item2 = FakeInvoiceItem.new(2, 1)
    invoice_item3 = FakeInvoiceItem.new(3, 2)

    @invoice_items = [
      invoice_item1,
      invoice_item2,
      invoice_item3
    ]

  end

  def test_it_knows_its_parent
    sales_engine = "fake_sales_engine"

    repo = InvoiceItemRepository.new(sales_engine)

    assert sales_engine, repo.sales_engine
  end

  def test_it_has_merchants
    sales_engine = "fake_sales_engine"

    repo = InvoiceItemRepository.new(sales_engine)

    assert [], repo.invoice_items
  end

  def test_it_loads_the_data
    path         = './data/fixtures/invoice_items.csv'
    sales_engine = "fake_sales_engine"
    repo         = InvoiceItemRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 10, repo.invoice_items.size
    assert_equal 10, repo.invoice_items.last.id
  end

  def test_it_finds_invoice_items_by_item_id
      sales_engine   = "fake sales engine"
      repo           = InvoiceItemRepository.new(sales_engine)
      item_id             = 2
      repo.invoice_items = invoice_items

      invoice_items = repo.find_invoice_items_by_item_id(item_id)

      assert_equal 2, invoice_items.size
  end

end


