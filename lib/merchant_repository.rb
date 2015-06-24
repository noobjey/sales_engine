require_relative 'load_file'
require_relative 'merchant'

class MerchantRepository
  attr_reader :sales_engine

  attr_accessor :merchants

  include LoadFile

  def initialize(sales_engine)
    @merchants    = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file       = load_file(path)
    @merchants = file.map do |line|
      Merchant.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants[Random.new.rand(merchants.size)]
  end

  def find_all_by_id(id)
    merchants.find_all { |merchant| merchant.id.eql?(id) }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name.downcase.eql?(name.downcase) }
  end

  def find_all_by_created_at(created_at)
    merchants.find_all { |merchant| merchant.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    merchants.find_all { |merchant| merchant.updated_at.eql?(updated_at) }
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id.eql?(id) }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase.eql?(name.downcase) }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at.eql?(updated_at) }
  end

  # Upstream
  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_id(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end
end
