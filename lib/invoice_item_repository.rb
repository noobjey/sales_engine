require_relative 'load_file'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_accessor :sales_engine,
                :invoice_items

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def load_data(path)
    file       = load_file(path)
    @invoice_items = file.map do |line|
      InvoiceItem.new(line, self)
    end
    file.close
  end

  def find_invoice_items_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id.eql?(item_id) }
  end
end
