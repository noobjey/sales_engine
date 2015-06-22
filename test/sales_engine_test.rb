require_relative "test_helper"
require_relative "../lib/sales_engine"
require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"

class SalesEngineTest < Minitest::Test
  def test_it_creates_a_merchant_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.merchant_repository.is_a?(MerchantRepository)
  end

  def test_it_passes_itself_to_merchant_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
  end

  def test_it_loads_the_merchant_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.merchant_repository = repo
    repo.expect(:load_data, nil, ["#{path}/merchants.csv"])
    engine.startup

    repo.verify
  end

  def test_it_stores_the_path_to_the_data
    path   = "the path"
    engine = SalesEngine.new(path)

    assert_equal path, engine.filepath
  end

  def test_it_creates_an_item_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.item_repository.is_a?(ItemRepository)
  end

  def test_it_passes_itself_to_item_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.item_repository.sales_engine
  end

  def test_it_loads_the_items_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:load_data, nil, ["#{path}/items.csv"])
    engine.startup

    repo.verify
  end

  def test_it_creates_an_invoice_item_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.invoice_item_repository.is_a?(InvoiceItemRepository)
  end

  def test_it_passes_itself_to_invoice_items_repository
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.invoice_item_repository.sales_engine
  end

  def test_it_loads_the_invoice_items_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.invoice_item_repository = repo
    repo.expect(:load_data, nil, ["#{path}/invoice_items.csv"])
    engine.startup

    repo.verify
  end

  def test_it_finds_items_by_merchant_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:find_items_by_merchant_id, nil, [1])
    engine.find_items_by_merchant_id(1)

    repo.verify
  end

  def test_it_finds_merchant_by_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.merchant_repository = repo
    repo.expect(:find_merchant, nil, [1])
    engine.find_merchant_by_id(1)

    repo.verify
  end

  def test_it_finds_invoice_items_by_merchant_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.invoice_item_repository = repo
    repo.expect(:find_by_merchant_id, nil, [1])
    engine.find_invoice_items_by_merchant_by_id(1)

    repo.verify
  end

  def test_smoke
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal 'Schroeder-Jerde', engine.find_merchant_by_id(1).name
    assert_equal 10, engine.find_items_by_merchant_id(1).length
    assert_equal 32301, engine.find_items_by_merchant_id(1)[2].unit_price
  end
end
