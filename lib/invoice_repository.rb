require_relative 'invoice'
require_relative 'load_file'

class InvoiceRepository
  attr_reader :sales_engine,
              :invoices

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoices        = []
  end

  def load_data(path)
    file   = load_file(path)
    @invoices = file.map do |line|
      Invoice.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end
end
