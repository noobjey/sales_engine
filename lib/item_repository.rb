# require_relative 'item'

class ItemRepository
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def load_data(path)

  end

end
