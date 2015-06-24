require_relative 'invoice'
require_relative 'load_file'

class InvoiceRepository
  attr_reader   :sales_engine
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
end
