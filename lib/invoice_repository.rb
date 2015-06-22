require_relative 'invoice'
require_relative 'load_file'

class InvoiceRepository
  attr_reader :sales_engine,
              :items

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items        = []
  end

  def load_data(path)
    file   = load_file(path)
    @items = file.map do |line|
      Invoice.new(line, self)
    end
  end
end