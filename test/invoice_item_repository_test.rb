require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items,
              :fake_sales_engine,
              :fixture_path,
              :invoice_item_input,
              :new_invoice_item_input,
              :fake_item,
              :mock_item

  class FakeItem
    attr_accessor :id,
                  :unit_price

    def initialize(id = 0)
      @id = id
      @unit_price = 0
    end
  end

  def setup
    @fake_sales_engine  = "fake sales engine"
    @fixture_path       = "./data/fixtures/invoice_items.csv"
    @fake_item          = FakeItem.new
    @mock_item = MiniTest::Mock.new


    @invoice_item_input = {
      id:         1,
      item_id:    539,
      invoice_id: 1,
      quantity:   5,
      unit_price: BigDecimal.new(13635),
      created_at: Date.parse("2012-03-27 14:54:09 UTC"),
      updated_at: Date.parse("2013-03-27 14:54:09 UTC")
    }

    invoice_item1 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item2 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item3 = InvoiceItem.new(invoice_item_input, nil)
    invoice_item4 = InvoiceItem.new(invoice_item_input, nil)

    @invoice_items = [invoice_item1, invoice_item2, invoice_item3, invoice_item4]

    @new_invoice_item_input = [FakeItem.new, FakeItem.new, FakeItem.new]
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

    assert_equal 4, repo.find_all_by_unit_price(invoice_item_input[:unit_price]).size
    assert_equal invoice_item_input[:unit_price], repo.find_all_by_unit_price(invoice_item_input[:unit_price]).first.unit_price
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

    assert_equal invoice_item_input[:unit_price], repo.find_by_unit_price(invoice_item_input[:unit_price]).unit_price
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

  def test_it_finds_invoice_by_invoice_id
    sales_engine = Minitest::Mock.new
    repo         = InvoiceItemRepository.new(sales_engine)

    sales_engine.expect(:find_invoice_by_id, nil, [invoice_item_input[:invoice_id]])
    repo.find_invoice_by_id(invoice_item_input[:invoice_id])

    sales_engine.verify
  end

  def test_it_finds_item_by_item_id
    sales_engine = Minitest::Mock.new
    repo         = InvoiceItemRepository.new(sales_engine)

    sales_engine.expect(:find_item_by_id, nil, [invoice_item_input[:item_id]])
    repo.find_item_by_id(invoice_item_input[:item_id])

    sales_engine.verify
  end


  def test_new_invoice_item_has_next_unique_id
    repo               = InvoiceItemRepository.new(fake_sales_engine)
    last_id            = 34
    expected_id        = last_id + 1
    fake_item.id = last_id
    repo.invoice_items      = [fake_item]

    repo.create(new_invoice_item_input, nil)

    assert_equal expected_id, repo.invoice_items.find { |invoice| invoice.id.eql?(expected_id) }.id
  end

  def test_new_invoice_item_has_item
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    fake_item.id = 539
    items = [fake_item]

    repo.create(items, nil)

    assert_equal 539, repo.invoice_items.first.item_id
  end

  def test_new_invoice_item_has_invoice
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    invoice_id = 222

    repo.create(new_invoice_item_input, invoice_id)

    assert_equal 222, repo.invoice_items.first.invoice_id
  end

  def test_new_invoice_item_has_a_unit_price
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    unit_price = BigDecimal.new(33333)/100
    fake_item.unit_price = unit_price
    items = [fake_item]

    repo.create(items, nil)

    assert_equal unit_price, repo.invoice_items.first.unit_price
  end

  def test_new_invoice_item_has_created_at
    repo          = InvoiceItemRepository.new(fake_sales_engine)

    repo.create(new_invoice_item_input, nil)

    assert_equal Date.today, repo.invoice_items.first.created_at
  end

  def test_new_invoice_item_has_updated_at
    repo          = InvoiceItemRepository.new(fake_sales_engine)

    repo.create(new_invoice_item_input, nil)

    assert_equal Date.today, repo.invoice_items.first.updated_at
  end

  def test_new_invoice_item_quantity_is_one_when_one_item_of_that_type_in_repo
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    single_item = [fake_item]

    repo.create(single_item, nil)

    assert_equal 1, repo.invoice_items.first.quantity
  end

  def test_two_new_invoice_item_quantity_is_two_when_two_same_items
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    items = [fake_item, fake_item]

    repo.create(items, nil)

    assert_equal 2, repo.invoice_items.first.quantity
  end

  def test_new_invoice_item_is_added_to_the_repo_when_one_item
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = @invoice_items
    single_item = [fake_item]

    repo.create(single_item, nil)

    assert_equal 5, repo.invoice_items.size
  end

  def test_new_invoice_item_is_added_to_the_repo_when_two_items_of_same_type
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = @invoice_items
    single_item = [fake_item]

    repo.create(single_item, nil)

    assert_equal 5, repo.invoice_items.size
  end

  def test_two_new_invoice_items_added_to_the_repo_when_two_different_items
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = @invoice_items
    fake_item1 = FakeItem.new(1)
    fake_item2 = FakeItem.new(2)
    items = [fake_item1, fake_item2]

    repo.create(items, nil)

    assert_equal 6, repo.invoice_items.size
  end

  def test_two_new_invoice_items_added_with_quantity
    repo          = InvoiceItemRepository.new(fake_sales_engine)
    repo.invoice_items = @invoice_items
    fake_item1 = FakeItem.new(1)
    fake_item2 = FakeItem.new(2)
    fake_item3 = FakeItem.new(1)
    items = [fake_item1, fake_item2, fake_item3]

    repo.create(items, nil)

    assert_equal 6, repo.invoice_items.size
    assert_equal 2, repo.find_by_item_id(fake_item1.id).quantity
    assert_equal 1, repo.find_by_item_id(fake_item2.id).quantity
  end
end
