class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def inspect
    "#<#{self.class} #{customers.size} rows>"
  end
end
