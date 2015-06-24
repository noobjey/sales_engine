require_relative "test_helper"
require_relative "../lib/sales_engine"
require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"

class SalesEngineTest < Minitest::Test


  def test_it_creates_the_repositories
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.merchant_repository.is_a?(MerchantRepository)
    assert_equal true, engine.item_repository.is_a?(ItemRepository)
    assert_equal true, engine.invoice_repository.is_a?(InvoiceRepository)
    assert_equal true, engine.invoice_item_repository.is_a?(InvoiceItemRepository)
  end

  def test_it_passes_itself_to_repositories
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
    assert_equal engine, engine.item_repository.sales_engine
    assert_equal engine, engine.invoice_repository.sales_engine
    assert_equal engine, engine.invoice_item_repository.sales_engine
  end

  def test_it_stores_the_path_to_the_data
    path   = "the path"
    engine = SalesEngine.new(path)

    assert_equal path, engine.filepath
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

  def test_it_loads_the_items_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:load_data, nil, ["#{path}/items.csv"])
    engine.startup

    repo.verify
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

  def test_it_loads_the_invoice_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.invoice_repository = repo
    repo.expect(:load_data, nil, ["#{path}/invoices.csv"])
    engine.startup

    repo.verify
  end

  def test_it_finds_items_by_merchant_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:find_all_by_merchant_id, nil, [1])
    engine.find_items_by_merchant_id(1)

    repo.verify
  end

  def test_it_finds_merchant_by_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.merchant_repository = repo
    repo.expect(:find_by_id, nil, [1])
    engine.find_merchant_by_id(1)

    repo.verify
  end

  def test_it_finds_invoice_items_by_item_id
    engine = SalesEngine.new("the path")
    repo   = Minitest::Mock.new

    engine.invoice_item_repository = repo
    repo.expect(:find_invoice_items_by_item_id, nil, [1])
    engine.find_invoice_items_by_item_id(1)
  end
end
