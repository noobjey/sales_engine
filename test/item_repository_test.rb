require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :items,
              :fake_sales_engine,
              :fixture_path,
              :item_input

  def setup
    @fake_sales_engine = "fake sales engine"
    @fixture_path      = './data/fixtures/items.csv'
    @item_input        = {
      id:          1,
      name:        'NaMe',
      description: 'deScriPtiOn',
      unit_price:  BigDecimal.new(1010),
      merchant_id: 1,
      created_at:  '2012-03-27 14:53:59 UTC',
      updated_at:  '2013-03-27 14:53:59 UTC'
    }

    item1 = Item.new(item_input, nil)
    item2 = Item.new(item_input, nil)
    item3 = Item.new(item_input, nil)
    item4 = Item.new(item_input, nil)

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
    repo = ItemRepository.new(fake_sales_engine)

    repo.load_data(@fixture_path)

    assert_equal 10, repo.items.size
    assert_equal 6, repo.items[5].id
  end

  def test_it_passes_itself_to_items
    path = @fixture_path
    repo = ItemRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.items.first.repository
  end

  def test_find_all_by_id
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_id(item_input[:id]).size
    assert_equal item_input[:id], repo.find_all_by_id(item_input[:id]).first.id
  end

  def test_find_all_by_name
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_name(item_input[:name]).size
    assert_equal item_input[:name], repo.find_all_by_name(item_input[:name]).first.name
  end

  def test_find_all_by_description
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_description(item_input[:description]).size
    assert_equal item_input[:description], repo.find_all_by_description(item_input[:description]).first.description
  end


  def test_find_all_by_unit_price
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_unit_price(item_input[:unit_price]/100).size
    assert_equal item_input[:unit_price]/100, repo.find_all_by_unit_price(item_input[:unit_price]/100).first.unit_price
  end

  def test_find_all_by_merchant_id
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_merchant_id(item_input[:merchant_id]).size
    assert_equal item_input[:merchant_id], repo.find_all_by_merchant_id(item_input[:merchant_id]).first.merchant_id
  end

  def test_find_all_by_created_at
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_created_at(item_input[:created_at]).size
    assert_equal item_input[:created_at], repo.find_all_by_created_at(item_input[:created_at]).first.created_at
  end

  def test_find_all_by_updated_at
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal 4, repo.find_all_by_updated_at(item_input[:updated_at]).size
    assert_equal item_input[:updated_at], repo.find_all_by_updated_at(item_input[:updated_at]).first.updated_at
  end


  def test_find_by_id
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:id], repo.find_by_id(item_input[:id]).id
  end

  def test_find_by_name
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:name], repo.find_by_name(item_input[:name]).name
  end

  def test_find_by_description
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:description], repo.find_by_description(item_input[:description]).description
  end

  def test_find_by_unit_price
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:unit_price]/100, repo.find_by_unit_price(item_input[:unit_price]/100).unit_price
  end

  def test_find_by_merchant_id
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:merchant_id], repo.find_by_merchant_id(item_input[:merchant_id]).merchant_id
  end

  def test_find_by_created_at
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:created_at], repo.find_by_created_at(item_input[:created_at]).created_at
  end

  def test_find_by_updated_at
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = items

    assert_equal item_input[:updated_at], repo.find_by_updated_at(item_input[:updated_at]).updated_at
  end

  def test_random_returns_a_random_instance
    repo       = ItemRepository.new(fake_sales_engine)
    expected   = 10000.times.map { |num| num }
    repo.items = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_all_returns_all_items_in_repository
    repo       = ItemRepository.new(fake_sales_engine)
    expected   = ['array with alot of items', 'like two']
    repo.items = expected

    assert_equal expected, repo.all
  end

  # Upstream lookups
  def test_find_merchant_by_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    id           = 1
    sales_engine.expect(:find_merchant_by_id, nil, [id])

    repo.find_merchant_by_id(id)

    sales_engine.verify
  end

  def test_it_finds_all_invoice_items_by_item_id
    sales_engine = Minitest::Mock.new
    repo         = ItemRepository.new(sales_engine)
    id           = 1
    sales_engine.expect(:find_invoice_items_by_item_id, nil, [id])

    repo.find_invoice_items_by_id(id)

    sales_engine.verify
  end

  # Downstream lookups
  def test_it_finds_all_items_by_merchant_id
    repo       = ItemRepository.new(fake_sales_engine)
    repo.items = @items

    assert_equal 4, repo.find_all_by_merchant_id(1).length
    assert_equal 1, repo.find_all_by_merchant_id(1).last.merchant_id
  end
end
