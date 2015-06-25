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
    items.find_all { |item| item.id.eql?(id) }
  end

  def find_all_by_name(name)
    items.find_all { |item| item.name.downcase.eql?(name.downcase) }
  end

  def find_all_by_description(description)
    items.find_all do |item|
      item.description.downcase.eql?(description.downcase)
    end
  end

  def find_all_by_unit_price(unit_price)
    items.find_all { |item| item.unit_price.eql?(unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id.eql?(merchant_id) }
  end

  def find_all_by_created_at(created_at)
    items.find_all { |item| item.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    items.find_all { |item| item.updated_at.eql?(updated_at) }
  end

  def find_by_id(id)
    items.find { |item| item.id.eql?(id) }
  end

  def find_by_name(name)
    items.find { |item| item.name.downcase.eql?(name.downcase) }
  end

  def find_by_description(description)
    items.find { |item| item.description.downcase.eql?(description.downcase) }
  end

  def find_by_unit_price(unit_price)
    items.find { |item| item.unit_price.eql?(unit_price) }
  end

  def find_by_merchant_id(merchant_id)
    items.find { |item| item.merchant_id.eql?(merchant_id) }
  end

  def find_by_created_at(created_at)
    items.find { |item| item.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    items.find { |item| item.updated_at.eql?(updated_at) }
  end

  # Going up the chain
  def find_invoice_items_by_id(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_id(id)
    sales_engine.find_merchant_by_id(id)
  end

  def most_items(top)
    pull_out_values(get_top_values(items_with_quantities_sold(self.items), top))
  end

  def most_revenue(top)
    item_revenue        = items.inject(Hash.new(0)) do |h, item|
      h[item] = item.revenue; h
    end
    sorted_item_revenue = item_revenue.sort_by { |k, v| v }.reverse.take(top)
    sorted_item_revenue.map { |item_revenue| item_revenue.first }
  end

  private

  def pull_out_values(instance)
    instance.map { |result| result.first }
  end

  def items_with_quantities_sold(items)
    items.inject(Hash.new(0)) do |hash, item|
      hash[item] = item.quantity_sold
      hash
    end
  end

  def get_top_values(hash_to_sort_by_value, top)
    hash_to_sort_by_value.sort_by { |k, v| v}.reverse.take(top)
  end
end

