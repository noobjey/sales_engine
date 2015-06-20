require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants

  class FakeMerchant
    attr_reader :id

    def initialize(id)
      @id = id
    end
  end

  def setup
    merchant1 = FakeMerchant.new(1)
    merchant2 = FakeMerchant.new(2)
    merchant3 = FakeMerchant.new(3)

    @merchants = [merchant1, merchant2, merchant3]

  end

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
    path         = './data/fixtures/merchants.csv'
    sales_engine = "fake_sales_engine"
    repo         = MerchantRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 4, repo.merchants.size
    assert_equal "Schroeder-Jerde", repo.merchants.first.name
  end

  def test_it_finds_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo         = MerchantRepository.new(sales_engine)

    sales_engine.expect(:find_items_by_merchant_id, nil, [1])
    repo.find_items(1)

    sales_engine.verify
  end

  def test_it_finds_merchant_by_id
    sales_engine   = "fake sales engine"
    repo           = MerchantRepository.new(sales_engine)
    id             = 1
    repo.merchants = merchants

    merchant = repo.find_merchant(id)

    assert_equal id, merchant.id
  end
end
