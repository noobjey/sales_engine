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
  end

  def test_it_passes_itself_to_repositories
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
    assert_equal engine, engine.item_repository.sales_engine
    assert_equal engine, engine.invoice_repository.sales_engine
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

  def test_it_loads_the_items_data
    path   = "./data/fixtures"
    engine = SalesEngine.new(path)
    repo   = Minitest::Mock.new

    engine.item_repository = repo
    repo.expect(:load_data, nil, ["#{path}/items.csv"])
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
    repo.expect(:find_merchant, nil, [1])
    engine.find_merchant_by_id(1)

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

  def test_smoke
    skip
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal 'Schroeder-Jerde', engine.find_merchant_by_id(1).name
    assert_equal 10,    engine.find_items_by_merchant_id(1).length
    assert_equal 32301, engine.find_items_by_merchant_id(1)[2].unit_price


    assert_equal 1,     engine.find_invoice_by_id(4).customer_id
    assert_equal 1,     engine.find_invoices_by_merchant_id(78).length
    assert_equal 3,     engine.find_invoices_by_merchant_id(78).first.id
    #  id, customer_id, merchant_id, status, created_at, updated_at
    #   1, 1, 26, shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    #   2, 1, 75, shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    #   3, 1, 78, shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    #   4, 1, 33, shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
  end
end
