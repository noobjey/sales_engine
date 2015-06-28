require_relative 'invoice'
require_relative 'load_file'

class InvoiceRepository
  attr_reader :sales_engine
  attr_accessor :invoices

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoices     = []
  end

  def load_data(path)
    file      = load_file(path)
    @invoices = file.map do |line|
      Invoice.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end

  def all
    @invoices
  end

  def random
    invoices[Random.new.rand(invoices.size)]
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id.eql?(id) }
  end

  def find_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id.eql?(customer_id) }
  end

  def find_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id.eql?(merchant_id) }
  end

  def find_by_status(status)
    invoices.find { |invoice| invoice.status.eql?(status) }
  end

  def find_by_created_at(created_at)
    invoices.find { |invoice| invoice.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    invoices.find { |invoice| invoice.updated_at.eql?(updated_at) }
  end

  def find_all_by_id(id)
    invoices.find_all { |invoice| invoice.id.eql?(id) }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id.eql?(customer_id) }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id.eql?(merchant_id) }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status.eql?(status) }
  end

  def find_all_by_created_at(created_at)
    invoices.find_all { |invoice| invoice.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    invoices.find_all { |invoice| invoice.updated_at.eql?(updated_at) }
  end

  # Upstream
  def find_transactions_by_id(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_id(customer_id)
  end

  def find_invoice_items_by_id(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_items(id)
    invoice_items = self.find_invoice_items_by_id(id)
    invoice_items.map do |invoice_item|
      sales_engine.find_item_by_id(invoice_item.item_id)
    end
  end

  def create(line)
    invoice_input = {
      id:          next_id,
      customer_id: line[:customer].id,
      merchant_id: line[:merchant].id,
      status:      line[:status],
      created_at:  Date.today.strftime("%F"),
      updated_at:  Date.today.strftime("%F")
    }

    invoices << Invoice.new(invoice_input, nil)

    sales_engine.create_invoice_items(line[:items], invoice_input[:id])
  end

  private

  def next_id
    return 1 if invoices.empty?
    invoices.sort_by{ |invoice| invoice.id }.reverse.first.id + 1
  end

end
