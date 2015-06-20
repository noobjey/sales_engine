require_relative "test_helper"
require_relative "../lib/sales_engine"
require_relative "../lib/merchant_repository"

class SalesEngineTest < Minitest::Test
  def test_it_creates_a_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.merchant_repository.is_a?(MerchantRepository)
  end

  def test_it_passes_itself_to_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
  end

  def test_it_loads_the_data
    engine = SalesEngine.new("../data")
    repo = Minitest::Mock.new

    engine.merchant_repository = repo
    repo.expect(:load_data, nil, ['../data/merchants.csv'])
    engine.startup

    repo.verify
  end

  def test_it_stores_the_path_to_the_data
    engine = SalesEngine.new("../data")

    assert_equal "../data", engine.filepath
  end

  def test_it_finds_items_by_merchant_id
    engine = SalesEngine.new("../data")
    repo = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:find_all_by_merchant_id, nil, [1])
    engine.find_items_by_merchant_id(1)

    repo.verify
  end
end