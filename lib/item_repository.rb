require_relative 'item'
require_relative 'load_file'

class ItemRepository
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
      Item.new(line, self)
    end
  end

  def find_merchant_by_id(id)
    sales_engine.find_merchant_by_id(1)
  end
end
