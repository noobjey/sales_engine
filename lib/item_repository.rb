require_relative 'item'
require_relative 'load_file'

class ItemRepository
  attr_reader :sales_engine
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

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  def all
    items
  end

  def random
    items[Random.new.rand(items.size)]
  end

  def find_all_by_id(id)
    items.select { |item| item.id.eql?(id) }
  end

  def find_all_by_name(name)
    items.select { |item| item.name.downcase.eql?(name.downcase) }
  end

  def find_all_by_description(description)
    items.select { |item| item.description.downcase.eql?(description.downcase) }
  end

  def find_all_by_unit_price(unit_price)
    items.select { |item| item.unit_price.eql?(unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id.eql?(merchant_id) }
  end

  def find_all_by_created_at(created_at)
    items.select { |item| item.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    items.select { |item| item.updated_at.eql?(updated_at) }
  end

  def find_by_id(id)
    items[items.index { |item| item.id.eql?(id) }]
  end

  def find_by_name(name)
    items[items.index { |item| item.name.downcase.eql?(name.downcase) }]
  end

  def find_by_description(description)
    items[items.index { |item| item.description.downcase.eql?(description.downcase) }]
  end

  def find_by_unit_price(unit_price)
    items[items.index { |item| item.unit_price.eql?(unit_price) }]
  end

  def find_by_merchant_id(merchant_id)
    items[items.index { |item| item.merchant_id.eql?(merchant_id) }]
  end

  def find_by_created_at(created_at)
    items[items.index { |item| item.created_at.eql?(created_at) }]
  end

  def find_by_updated_at(updated_at)
    items[items.index { |item| item.updated_at.eql?(updated_at) }]
  end

  # Going up the chain
  def find_invoice_items_by_id(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_id(id)
    sales_engine.find_merchant_by_id(1)
  end
end
