require_relative 'customer'
require_relative 'load_file'

class CustomerRepository
  attr_reader :sales_engine
  attr_accessor :customers

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @customers    = []
  end

  def load_data(path)
    file       = load_file(path)
    @customers = file.map do |line|
      Customer.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{customers.size} rows>"
  end

  def all
    customers
  end

  def random
    customers[Random.new.rand(customers.size)]
  end

  def find_by_id(id)
    customers.find { |customer| customer.id.eql?(id) }
  end

  def find_by_first_name(first_name)
    customers.find { |customer| customer.first_name.downcase.eql?(first_name.downcase) }
  end

  def find_by_last_name(last_name)
    customers.find { |customer| customer.last_name.downcase.eql?(last_name.downcase) }
  end

  def find_by_created_at(created_at)
    customers.find { |customer| customer.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    customers.find { |customer| customer.updated_at.eql?(updated_at) }
  end

  def find_all_by_id(id)
    customers.find_all { |customer| customer.id.eql?(id) }
  end

  def find_all_by_first_name(first_name)
    customers.find_all { |customer| customer.first_name.eql?(first_name) }
  end

  def find_all_by_last_name(last_name)
    customers.find_all { |customer| customer.last_name.eql?(last_name) }
  end

  def find_all_by_created_at(created_at)
    customers.find_all { |customer| customer.created_at.eql?(created_at) }
  end

  def find_all_by_updated_at(updated_at)
    customers.find_all { |customer| customer.updated_at.eql?(updated_at) }
  end

  # Upstream
  def find_invoices_by_customer_id(customer_id)
    sales_engine.find_invoices_by_customer_id(customer_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_id(merchant_id)
  end
end
