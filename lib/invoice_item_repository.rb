require_relative 'load_file'
require 'date'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_accessor :sales_engine,
                :invoice_items

  include LoadFile

  def initialize(sales_engine)
    @sales_engine  = sales_engine
    @invoice_items = []
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
    invoice_items.find do |invoice_item|
      invoice_item.invoice_id.eql?(invoice_id)
    end
  end

  def find_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity.eql?(quantity) }
  end

  def find_by_unit_price(unit_price)
    invoice_items.find do |invoice_item|
      invoice_item.unit_price.eql?(unit_price)
    end
  end

  def find_by_created_at(created_at)
    invoice_items.find do |invoice_item|
      invoice_item.created_at.eql?(created_at)
    end
  end

  def find_by_updated_at(updated_at)
    invoice_items.find do |invoice_item|
      invoice_item.updated_at.eql?(updated_at)
    end
  end


  def find_all_by_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.id.eql?(id) }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id.eql?(item_id) }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id.eql?(invoice_id)
    end
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all do |invoice_item|
      invoice_item.quantity.eql?(quantity)
    end
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all do |invoice_item|
      invoice_item.unit_price.eql?(unit_price)
    end
  end

  def find_all_by_created_at(created_at)
    invoice_items.find_all do |invoice_item|
      invoice_item.created_at.eql?(created_at)
    end
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.find_all do |invoice_item|
      invoice_item.updated_at.eql?(updated_at)
    end
  end

  def create(items, invoice_id)

    unique_items = items.uniq { |item| item.id }
    unique_items.each do |item|

      invoice_item_input = {
        id:         next_id,
        item_id:    item.id,
        invoice_id: invoice_id,
        quantity:   quantity_of_items(items, item.id),
        unit_price: items.first.unit_price,
        created_at: Date.today,
        updated_at: Date.today
      }

      invoice_items << InvoiceItem.new(invoice_item_input, self)
    end

  end

# Upstream
  def find_invoice_by_id(id)
    sales_engine.find_invoice_by_id(id)
  end

  def find_item_by_id(id)
    sales_engine.find_item_by_id(id)
  end

  private

  def next_id
    return 1 if invoice_items.empty?
    invoice_items.sort_by { |invoice| invoice.id }.reverse.first.id + 1
  end

  def quantity_of_items(items, id)
    # binding.pry
    items.count { |item| item.id.eql?(id) }
  end

end
