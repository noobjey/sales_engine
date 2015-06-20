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
    path = './data/fixtures/items.csv'
    sales_engine = "fake_sales_engine"
    repo = ItemRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 10, repo.items.size
    assert_equal 6, repo.items[5].id
  end

end
