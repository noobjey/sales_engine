require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_knows_its_parent
    sales_engine = "fake_sales_engine"

    repo = MerchantRepository.new(sales_engine)

    assert sales_engine, repo.sales_engine
  end

  def test_it_has_merchants
    sales_engine = "fake_sales_engine"

    repo = MerchantRepository.new(sales_engine)

    assert [], repo.merchants
  end

  def test_it_loads_the_data
    path = './data/fixtures/merchants.csv'
    sales_engine = "fake_sales_engine"
    repo = MerchantRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 4, repo.merchants.size
    assert_equal "Schroeder-Jerde", repo.merchants.first.name
  end

  def test_it_finds_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo = MerchantRepository.new(sales_engine)

    sales_engine.expect(:find_items_by_merchant_id, nil, [1])
    repo.find_items(1)

    sales_engine.verify
  end
end
