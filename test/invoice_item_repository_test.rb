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
      id:         1,
      item_id:    539,
      invoice_id: 1,
      quantity:   5,
      unit_price: BigDecimal.new(13635),
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2013-03-27 14:54:09 UTC"
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

  def test_it_passes_itself_to_invoice_items
    path = @fixture_path
    repo = InvoiceItemRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.invoice_items.first.repository
  end

  def test_find_all_by_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_id(invoice_item_input[:id]).size
    assert_equal invoice_item_input[:id], repo.find_all_by_id(invoice_item_input[:id]).first.id
  end

  def test_find_all_by_item_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_item_id(invoice_item_input[:item_id]).size
    assert_equal invoice_item_input[:item_id], repo.find_all_by_item_id(invoice_item_input[:item_id]).first.item_id
  end

  def test_find_all_by_invoice_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_invoice_id(invoice_item_input[:invoice_id]).size
    assert_equal invoice_item_input[:invoice_id], repo.find_all_by_invoice_id(invoice_item_input[:invoice_id]).first.invoice_id
  end

  def test_find_all_by_unit_price
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_unit_price(invoice_item_input[:unit_price]/100).size
    assert_equal invoice_item_input[:unit_price]/100, repo.find_all_by_unit_price(invoice_item_input[:unit_price]/100).first.unit_price
  end

  def test_find_all_by_quantity
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_quantity(invoice_item_input[:quantity]).size
    assert_equal invoice_item_input[:quantity], repo.find_all_by_quantity(invoice_item_input[:quantity]).first.quantity
  end

  def test_find_all_by_created_at
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_created_at(invoice_item_input[:created_at]).size
    assert_equal invoice_item_input[:created_at], repo.find_all_by_created_at(invoice_item_input[:created_at]).first.created_at
  end

  def test_find_all_by_updated_at
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal 4, repo.find_all_by_updated_at(invoice_item_input[:updated_at]).size
    assert_equal invoice_item_input[:updated_at], repo.find_all_by_updated_at(invoice_item_input[:updated_at]).first.updated_at
  end

  def test_find_by_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:id], repo.find_by_id(invoice_item_input[:id]).id
  end

  def test_find_by_item_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:item_id], repo.find_by_item_id(invoice_item_input[:item_id]).item_id
  end

  def test_find_by_invoice_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:invoice_id], repo.find_by_invoice_id(invoice_item_input[:invoice_id]).invoice_id
  end

  def test_find_by_unit_price
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:unit_price]/100, repo.find_by_unit_price(invoice_item_input[:unit_price]/100).unit_price
  end

  def test_find_by_quantity
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:quantity], repo.find_by_quantity(invoice_item_input[:quantity]).quantity
  end

  def test_find_by_created_at
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:created_at], repo.find_by_created_at(invoice_item_input[:created_at]).created_at
  end

  def test_find_by_updated_at
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = invoice_items

    assert_equal invoice_item_input[:updated_at], repo.find_by_updated_at(invoice_item_input[:updated_at]).updated_at
  end

  def test_random_returns_a_random_instance
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    expected           = 10000.times.map { |num| num }
    repo.invoice_items = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_all_returns_all_invoice_items_in_repository
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    expected           = ['array with alot of invoice_items', 'like two']
    repo.invoice_items = expected

    assert_equal expected, repo.all
  end
end
