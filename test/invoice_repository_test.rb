require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoices,
              :fake_sales_engine,
              :fixture_path,
              :invoice_input,
              :new_invoice_input

  class FakeSalesEngine
    def create_invoice_items(inpu)

    end
  end

  def setup
    @fake_sales_engine = FakeSalesEngine.new

    @fixture_path  = './data/fixtures/invoices.csv'
    @invoice_input = {
      id:          1,
      customer_id: 5,
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


    @new_invoice_input = {
      customer: Minitest::Mock.new.expect(:id, 1, []),
      merchant: Minitest::Mock.new.expect(:id, 1, []),
      status:   "shipped",
      items:    [item1 = Minitest::Mock.new, item2 = Minitest::Mock.new, item3 = Minitest::Mock.new]
    }
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

    assert_equal Date.parse(invoice_input[:created_at]), repo.find_by_created_at(Date.parse(invoice_input[:created_at])).created_at
  end

  def test_find_by_updated_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal Date.parse(invoice_input[:updated_at]), repo.find_by_updated_at(Date.parse(invoice_input[:updated_at])).updated_at
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

    assert_equal 4, repo.find_all_by_created_at(Date.parse(invoice_input[:created_at])).size
    assert_equal Date.parse(invoice_input[:created_at]), repo.find_all_by_created_at(Date.parse(invoice_input[:created_at])).first.created_at
  end

  def test_find_all_by_updated_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = invoices

    assert_equal 4, repo.find_all_by_updated_at(Date.parse(invoice_input[:updated_at])).size
    assert_equal Date.parse(invoice_input[:updated_at]), repo.find_all_by_updated_at(Date.parse(invoice_input[:updated_at])).first.updated_at
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
    sales_engine      = Minitest::Mock.new
    repo              = InvoiceRepository.new(sales_engine)
    fake_invoice_item = MiniTest::Mock.new
    fake_invoice_item.expect(:item_id, 1, [])
    fake_invoice_items = [fake_invoice_item]

    sales_engine.expect(:find_invoice_items_by_invoice_id, fake_invoice_items, [invoice_input[:id]])
    sales_engine.expect(:find_item_by_id, nil, [1])
    repo.find_items(invoice_input[:id])

    sales_engine.verify
  end


  def test_new_invoice_is_added_to_the_repo
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal 2, repo.invoices.size
  end

  def test_new_invoice_has_next_unique_id
    repo               = InvoiceRepository.new(fake_sales_engine)
    last_id            = 34
    expected_id        = last_id + 1
    invoice_input[:id] = last_id
    repo.invoices      = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal expected_id, repo.invoices.find { |invoice| invoice.id.eql?(expected_id) }.id
  end

  def test_new_invoice_has_customer
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal 5, repo.invoices.first.customer_id
  end

  def test_new_invoice_has_merchant
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal 26, repo.invoices.first.merchant_id
  end

  def test_new_invoice_has_a_status
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal "shipped", repo.invoices.first.status
  end

  def test_new_invoice_has_created_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), repo.invoices.first.created_at
  end

  def test_new_invoice_has_updated_at
    repo          = InvoiceRepository.new(fake_sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    repo.create(new_invoice_input)

    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), repo.invoices.first.updated_at
  end

  def test_creates_invoice_items_for_new_invoice
    sales_engine  = Minitest::Mock.new
    repo          = InvoiceRepository.new(sales_engine)
    repo.invoices = [Invoice.new(invoice_input, nil)]

    sales_engine.expect(:create_invoice_items, nil, [new_invoice_input[:items]])
    repo.create(new_invoice_input)

    sales_engine.verify
  end
end
