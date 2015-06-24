require_relative 'load_file'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_accessor :sales_engine
  attr_accessor :invoice_items

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def load_data(path)
    file           = load_file(path)
    @invoice_items = file.map do |line|
      InvoiceItem.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def random
    invoice_items[Random.new.rand(invoice_items.size)]
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id.eql?(id) }
  end

  def find_by_item_id(item_id)
    invoice_items.find { |invoice_item| invoice_item.item_id.eql?(item_id) }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id.eql?(invoice_id) }
  end

  def find_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity.eql?(quantity) }
  end

  def find_by_unit_price(unit_price)
    invoice_items.find { |invoice_item| invoice_item.unit_price.eql?(unit_price) }
  end

  def find_by_created_at(created_at)
    invoice_items.find { |invoice_item| invoice_item.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    invoice_items.find { |invoice_item| invoice_item.updated_at.eql?(updated_at) }
  end


  def find_all_by_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.id.eql?(id) }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id.eql?(item_id) }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id.eql?(invoice_id) }
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all { |invoice_item| invoice_item.quantity.eql?(quantity) }
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all { |invoice_item| invoice_item.unit_price.eql?(unit_price) }
  end

  def find_all_by_created_at(created_at)
    invoice_items.find_all { |invoice_item| invoice_item.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.find_all { |invoice_item| invoice_item.updated_at.eql?(updated_at) }
  end
end
