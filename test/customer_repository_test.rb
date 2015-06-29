require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers,
              :fake_sales_engine,
              :fixture_path,
              :customer_input

  def setup
    @fake_sales_engine = "fake sales engine"
    @fixture_path      = './data/fixtures/customers.csv'
    @customer_input    = {
      id:         1,
      first_name: 'Joey',
      last_name:  'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2013-03-27 14:54:09 UTC'
    }

    customer1 = Customer.new(customer_input, nil)
    customer2 = Customer.new(customer_input, nil)
    customer3 = Customer.new(customer_input, nil)
    customer4 = Customer.new(customer_input, nil)

    @customers = [customer1, customer2, customer3, customer4]
  end

  def test_it_knows_its_parent
    repo = CustomerRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_customers
    repo = CustomerRepository.new(fake_sales_engine)

    assert [], repo.customers
  end

  def test_it_loads_the_data
    repo = CustomerRepository.new(fake_sales_engine)

    repo.load_data(fixture_path)

    assert_equal 11, repo.customers.size
    assert_equal 'Joey', repo.customers.first.first_name
  end

  def test_it_passes_itself_to_customers
    path = @fixture_path
    repo = CustomerRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.customers.first.repository
  end

  def test_it_has_an_inspect
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal "#<CustomerRepository 4 rows>", repo.inspect
  end

  def test_find_all_by_id
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal 4, repo.find_all_by_id(customer_input[:id]).size
    assert_equal customer_input[:id], repo.find_all_by_id(customer_input[:id]).first.id
  end

  def test_find_all_by_first_name
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal 4, repo.find_all_by_first_name(customer_input[:first_name]).size
    assert_equal customer_input[:first_name], repo.find_all_by_first_name(customer_input[:first_name]).first.first_name
  end

  def test_find_all_by_last_name
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal 4, repo.find_all_by_last_name(customer_input[:last_name]).size
    assert_equal customer_input[:last_name], repo.find_all_by_last_name(customer_input[:last_name]).first.last_name
  end

  def test_find_all_by_created_at
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal 4, repo.find_all_by_created_at(Date.parse(customer_input[:created_at])).size
    assert_equal Date.parse(customer_input[:created_at]), repo.find_all_by_created_at(Date.parse(customer_input[:created_at])).first.created_at
  end

  def test_find_all_by_updated_at
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal 4, repo.find_all_by_updated_at(Date.parse(customer_input[:updated_at])).size
    assert_equal Date.parse(customer_input[:updated_at]), repo.find_all_by_updated_at(Date.parse(customer_input[:updated_at])).first.updated_at
  end

  def test_find_by_id
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal customer_input[:id], repo.find_by_id(customer_input[:id]).id
  end

  def test_find_by_first_name
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal customer_input[:first_name], repo.find_by_first_name(customer_input[:first_name]).first_name
  end

  def test_find_by_last_name
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal customer_input[:last_name], repo.find_by_last_name(customer_input[:last_name]).last_name
  end

  def test_find_by_created_at
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal Date.parse(customer_input[:created_at]), repo.find_by_created_at(Date.parse(customer_input[:created_at])).created_at
  end

  def test_find_by_updated_at
    repo           = CustomerRepository.new(fake_sales_engine)
    repo.customers = customers

    assert_equal Date.parse(customer_input[:updated_at]), repo.find_by_updated_at(Date.parse(customer_input[:updated_at])).updated_at
  end

  def test_random_returns_a_random_instance
    repo           = CustomerRepository.new(fake_sales_engine)
    expected       = 10000.times.map { |num| num }
    repo.customers = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_all_returns_all_customers_in_repository
    repo           = CustomerRepository.new(fake_sales_engine)
    expected       = ['array with alot of customers', 'like two']
    repo.customers = expected

    assert_equal expected, repo.all
  end

  # Upstream
  def test_it_finds_invoices_by_customer_id
    sales_engine = Minitest::Mock.new
    repo         = CustomerRepository.new(sales_engine)

    sales_engine.expect(:find_invoices_by_customer_id, nil, [customer_input[:id]])
    repo.find_invoices_by_customer_id(customer_input[:id])

    sales_engine.verify
  end

end
