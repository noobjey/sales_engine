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
      id:           1,
      customer_id:  1,
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
    sales_engine = "fake_sales_engine"

    repo = InvoiceRepository.new(sales_engine)

    assert sales_engine, repo.sales_engine
  end

  def test_it_has_invoices
    sales_engine = "fake_sales_engine"

    repo = InvoiceRepository.new(sales_engine)

    assert [], repo.invoices
  end

  def test_it_loads_the_data
    path         = './data/fixtures/invoices.csv'
    sales_engine = "fake_sales_engine"
    repo         = InvoiceRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal 9, repo.invoices.size
    assert_equal 6, repo.invoices[5].id
  end

  def test_it_passes_itself_to_invoices
    path         = './data/fixtures/invoices.csv'
    sales_engine = "fake sales engine"
    repo         = InvoiceRepository.new(sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.invoices.first.repository
  end
end
