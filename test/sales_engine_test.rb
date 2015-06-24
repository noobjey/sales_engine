require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test
  attr_reader :path,
              :fake_repo

  def setup
    @fake_sales_engine = "fake sales engine"
    @path              = "./data/fixtures"
    @fake_repo         = Minitest::Mock.new
  end

  def test_it_creates_the_repositories
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal true, engine.merchant_repository.is_a?(MerchantRepository)
    assert_equal true, engine.item_repository.is_a?(ItemRepository)
    assert_equal true, engine.invoice_repository.is_a?(InvoiceRepository)
    assert_equal true, engine.invoice_item_repository.is_a?(InvoiceItemRepository)
    assert_equal true, engine.customer_repository.is_a?(CustomerRepository)
    assert_equal true, engine.transaction_repository.is_a?(TransactionRepository)
  end

  def test_it_passes_itself_to_repositories
    engine = SalesEngine.new("./data/fixtures")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
    assert_equal engine, engine.item_repository.sales_engine
    assert_equal engine, engine.invoice_repository.sales_engine
    assert_equal engine, engine.invoice_item_repository.sales_engine
    assert_equal engine, engine.customer_repository.sales_engine
    assert_equal engine, engine.transaction_repository.sales_engine
  end

  def test_it_stores_the_path_to_the_data
    data_path = "the path"
    engine    = SalesEngine.new(data_path)

    assert_equal data_path, engine.filepath
  end

  def test_it_loads_the_merchant_data
    engine = SalesEngine.new(path)

    engine.merchant_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/merchants.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_loads_the_items_data
    engine = SalesEngine.new(path)

    engine.item_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/items.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_loads_the_invoice_items_data
    engine = SalesEngine.new(path)

    engine.invoice_item_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/invoice_items.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_loads_the_invoice_data
    engine = SalesEngine.new(path)

    engine.invoice_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/invoices.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_loads_the_customer_data
    engine = SalesEngine.new(path)

    engine.customer_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/customers.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_loads_the_transaction_data
    engine = SalesEngine.new(path)

    engine.transaction_repository = fake_repo
    fake_repo.expect(:load_data, nil, ["#{path}/transactions.csv"])
    engine.startup

    fake_repo.verify
  end

  def test_it_finds_items_by_merchant_id
    engine = SalesEngine.new("the path")

    engine.item_repository = fake_repo
    fake_repo.expect(:find_all_by_merchant_id, nil, [1])
    engine.find_items_by_merchant_id(1)

    fake_repo.verify
  end

  def test_it_finds_item_by_id
    engine = SalesEngine.new("the path")

    engine.item_repository = fake_repo
    fake_repo.expect(:find_by_id, nil, [1])
    engine.find_item_by_id(1)

    fake_repo.verify
  end

  def test_it_finds_merchant_by_id
    engine = SalesEngine.new("the path")

    engine.merchant_repository = fake_repo
    fake_repo.expect(:find_by_id, nil, [1])
    engine.find_merchant_by_id(1)

    fake_repo.verify
  end

  def test_it_finds_invoice_items_by_item_id
    engine = SalesEngine.new("the path")

    engine.invoice_item_repository = fake_repo
    fake_repo.expect(:find_all_by_item_id, nil, [1])
    engine.find_invoice_items_by_item_id(1)

    fake_repo.verify
  end

  def test_it_finds_invoice_by_id
    engine = SalesEngine.new("the path")

    engine.invoice_repository = fake_repo
    fake_repo.expect(:find_by_id, nil, [1])
    engine.find_invoice_by_id(1)

    fake_repo.verify
  end

  def test_it_finds_invoices_by_customer_id
    engine = SalesEngine.new("the path")

    engine.invoice_repository = fake_repo
    fake_repo.expect(:find_all_by_customer_id, nil, [1])
    engine.find_invoices_by_customer_id(1)

    fake_repo.verify
  end

  def test_it_finds_transactions_by_invoice_id
    engine = SalesEngine.new("the path")

    engine.transaction_repository = fake_repo
    fake_repo.expect(:find_all_by_invoice_id, nil, [1])
    engine.find_transactions_by_invoice_id(1)

    fake_repo.verify
  end

  def test_it_finds_customers_by_customer_id
    engine = SalesEngine.new("the path")

    engine.customer_repository = fake_repo
    fake_repo.expect(:find_by_id, nil, [1])
    engine.find_customer_by_id(1)

    fake_repo.verify
  end

end
