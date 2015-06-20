require_relative 'test_helper'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test

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
end
