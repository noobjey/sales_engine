require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoices,
              :fake_sales_engine,
              :fixture_path,
              :invoice_input

  def setup
    @fake_sales_engine = "fake sales engine"
    @fixture_path      = './data/fixtures/invoices.csv'
    @invoice_input = {
      id:          1,
      customer_id: 1,
      merchant_id: 26,
      status:      "shipped",
      created_at:  "2012-03-25 09:54:09 UTC",
      updated_at:  "2012-03-25 09:54:09 UTC"
    }

    invoice1 = Invoice.new(invoice_input, nil)
    invoice2 = Invoice.new(invoice_input, nil)
    invoice3 = Invoice.new(invoice_input, nil)
    invoice4 = Invoice.new(invoice_input, nil)

    @invoices = [invoice1, invoice2, invoice3, invoice4]
  end

  def test_it_knows_its_parent
    repo = InvoiceRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_invoices
    repo = InvoiceRepository.new(fake_sales_engine)

    assert [], repo.invoices
  end

  def test_it_loads_the_data
    repo = InvoiceRepository.new(fake_sales_engine)

    repo.load_data(fixture_path)

    assert_equal 9, repo.invoices.size
    assert_equal 6, repo.invoices[5].id
  end

  def test_it_passes_itself_to_invoices
    repo = InvoiceRepository.new(fake_sales_engine)

    repo.load_data(fixture_path)

    assert_equal repo, repo.invoices.first.repository
  end

  def test_all_returns_all_invoices_in_repository
    repo          = InvoiceRepository.new(fake_sales_engine)
    expected      = ['array with alot of invoices', 'like two']
    repo.invoices = expected

    assert_equal expected, repo.all
  end

  def test_random_returns_a_random_instance
    repo          = InvoiceRepository.new(fake_sales_engine)
    expected      = 10000.times.map { |num| num }
    repo.invoices = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_find_by_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:id], repo.find_by_id(invoice_input[:id]).id
  end

  def test_find_by_customer_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:customer_id], repo.find_by_customer_id(invoice_input[:customer_id]).customer_id
  end

  def test_find_by_merchant_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:merchant_id], repo.find_by_merchant_id(invoice_input[:merchant_id]).merchant_id
  end

  def test_find_by_status
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:status], repo.find_by_status(invoice_input[:status]).status
  end

  def test_find_by_created_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:created_at], repo.find_by_created_at(invoice_input[:created_at]).created_at
  end

  def test_find_by_updated_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal invoice_input[:updated_at], repo.find_by_updated_at(invoice_input[:updated_at]).updated_at
  end

  def test_find_all_by_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_id(invoice_input[:id]).size
    assert_equal invoice_input[:id], repo.find_all_by_id(invoice_input[:id]).first.id
  end

  def test_find_all_by_customer_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_customer_id(invoice_input[:customer_id]).size
    assert_equal invoice_input[:customer_id], repo.find_all_by_customer_id(invoice_input[:customer_id]).first.customer_id
  end

  def test_find_all_by_merchant_id
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_merchant_id(invoice_input[:merchant_id]).size
    assert_equal invoice_input[:merchant_id], repo.find_all_by_merchant_id(invoice_input[:merchant_id]).first.merchant_id
  end

  def test_find_all_by_status
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_status(invoice_input[:status]).size
    assert_equal invoice_input[:status], repo.find_all_by_status(invoice_input[:status]).first.status
  end

  def test_find_all_by_created_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_created_at(invoice_input[:created_at]).size
    assert_equal invoice_input[:created_at], repo.find_all_by_created_at(invoice_input[:created_at]).first.created_at
  end

  def test_find_all_by_updated_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_updated_at(invoice_input[:updated_at]).size
    assert_equal invoice_input[:updated_at], repo.find_all_by_updated_at(invoice_input[:updated_at]).first.updated_at
  end

  # Upstream
  def test_it_finds_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo         = InvoiceRepository.new(sales_engine)

    sales_engine.expect(:find_transactions_by_invoice_id, nil, [invoice_input[:id]])
    repo.find_transactions_by_id(invoice_input[:id])

    sales_engine.verify
  end

  def test_it_finds_customers_by_customer_id
    sales_engine = Minitest::Mock.new
    repo         = InvoiceRepository.new(sales_engine)

    sales_engine.expect(:find_customer_by_id, nil, [invoice_input[:customer_id]])
    repo.find_customer_by_customer_id(invoice_input[:customer_id])

    sales_engine.verify
  end

  def test_it_finds_invoice_items_by_id
    sales_engine = Minitest::Mock.new
    repo         = InvoiceRepository.new(sales_engine)

    sales_engine.expect(:find_invoice_items_by_invoice_id, nil, [invoice_input[:id]])
    repo.find_invoice_items_by_id(invoice_input[:id])

    sales_engine.verify
  end

  def test_it_finds_items
    sales_engine = Minitest::Mock.new
    repo         = InvoiceRepository.new(sales_engine)
    fake_invoice_item = MiniTest::Mock.new
    fake_invoice_item.expect(:item_id, 1, [])
    fake_invoice_items = [fake_invoice_item]

    sales_engine.expect(:find_invoice_items_by_invoice_id, fake_invoice_items, [invoice_input[:id]])
    sales_engine.expect(:find_item_by_id, nil, [1])
    repo.find_items(invoice_input[:id])

    sales_engine.verify
  end

end
