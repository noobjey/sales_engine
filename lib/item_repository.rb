require_relative 'item'
require_relative 'load_file'

class ItemRepository
  attr_reader   :sales_engine
  attr_accessor :items

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items        = []
  end

  def load_data(path)
    file   = load_file(path)
    @items = file.map do |line|
      Item.new(line, self)
    end
  end

  #Going down the chain
  def find_items_by_merchant_id(id)
    items.select { |item| item.merchant_id.eql?(id) }
  end

  # Going up the chain
  def find_invoice_items_by_id(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_id(id)
    sales_engine.find_merchant_by_id(1)
  end
end
