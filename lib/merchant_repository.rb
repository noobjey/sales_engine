require_relative 'load_file'
require_relative 'merchant'

class MerchantRepository
  attr_reader :sales_engine, :merchants
  include LoadFile

  def initialize(sales_engine)
    @merchants = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @merchants = file.map do |line|
      Merchant.new(line, self)
    end
    file.close
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end
end