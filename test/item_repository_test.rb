require_relative 'test_helper'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  attr_reader :items

  class FakeItem
    attr_reader :merchant_id

    def initialize(merchant_id)
      @merchant_id = merchant_id
    end
  end

  def setup
    item1 = FakeItem.new(1)
    item2 = FakeItem.new(2)
    item3 = FakeItem.new(3)
    item4 = FakeItem.new(1)

    @items = [item2, item1, item3, item4]

  end

  def test_it_knows_its_parent
    sales_engine = "fake_sales_engine"

    repo = ItemRepository.new(sales_engine)

    assert sales_engine, repo.sales_engine
  end

  def test_it_has_items
    sales_engine = "fake_sales_engine"

    repo = ItemRepository.new(sales_engine)

    assert [], repo.items
  end

  def test_it_loads_the_data
    path         = './data/fixtures/items.csv'
    sales_engine = "fake_sales_engine"
    repo         = ItemRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 10, repo.items.size
    assert_equal 6, repo.items[5].id
  end

  def test_it_passes_itself_to_items
    path         = './data/fixtures/items.csv'
    sales_engine = "fake sales engine"
    repo         = ItemRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.items.first.repository
  end

  def test_find_merchant_by_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    id           = 1
    sales_engine.expect(:find_merchant_by_id, nil, [id])

    repo.find_merchant_by_id(id)

    sales_engine.verify
  end

  def test_it_finds_all_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    repo.items   = @items

    assert_equal 2, repo.find_items_by_merchant_id(1).length
    assert_equal 1, repo.find_items_by_merchant_id(1).last.merchant_id
  end

  def test_it_finds_all_invoice_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    id           = 1
    sales_engine.expect(:find_invoice_items_by_merchant_id, nil, [id])

    repo.find_invoice_items_by_id(id)

    sales_engine.verify
  end
end
