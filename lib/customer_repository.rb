class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end
end
