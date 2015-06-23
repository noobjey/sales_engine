require_relative 'test_helper'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  attr_reader :items,
              :fake_sales_engine

  class FakeItem
    attr_reader :merchant_id

    def initialize(merchant_id)
      @merchant_id = merchant_id

    end
  end

  def setup
    @fake_sales_engine = "fake sales engine"
    item1 = FakeItem.new(1)
    item2 = FakeItem.new(2)
    item3 = FakeItem.new(3)
    item4 = FakeItem.new(1)

    @items = [item2, item1, item3, item4]

  end

  def test_it_knows_its_parent
    repo = ItemRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_items
    repo = ItemRepository.new(fake_sales_engine)

    assert [], repo.items
  end

  def test_it_loads_the_data
    path         = './data/fixtures/items.csv'
    repo         = ItemRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal 10, repo.items.size
    assert_equal 6, repo.items[5].id
  end

  def test_it_passes_itself_to_items
    path         = './data/fixtures/items.csv'
    repo         = ItemRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.items.first.repository
  end


  # id,name,description,unit_price,merchant_id,created_at,updated_at
  # all returns all instances
  # random returns a random instance
  # find_by_X(match), where X is some attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, customer_repository.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  #   find_all_by_X(match) works just like find_by_X except it returns a collection of all matches. If there is no match, it returns an empty Array.



  def test_random_returns_a_random_instance
    repo         = ItemRepository.new(fake_sales_engine)
    expected = 10000.times.map { |num| num }
    repo.items = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_all_returns_all_items_in_repository
    repo         = ItemRepository.new(fake_sales_engine)
    expected = ['with alot of items', 'like two']
    repo.items = expected

    assert_equal expected, repo.all
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
    repo         = ItemRepository.new(fake_sales_engine)
    repo.items   = @items

    assert_equal 2, repo.find_items_by_merchant_id(1).length
    assert_equal 1, repo.find_items_by_merchant_id(1).last.merchant_id
  end

  def test_it_finds_all_invoice_items_by_item_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    id           = 1
    sales_engine.expect(:find_invoice_items_by_item_id, nil, [id])

    repo.find_invoice_items_by_id(id)

    sales_engine.verify
  end
end
