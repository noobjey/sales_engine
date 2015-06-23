require_relative 'test_helper'
require_relative '../lib/customer.rb'

class CustomerTest < Minitest::Test
  attr_reader :data

  def setup
    @data = {
              id:         "1",
              first_name: "Joey",
              last_name:  "Ondricka",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
  end

  def test_it_has_the_expected_initialized_id
    customer = Customer.new(data, nil)

    assert 1, customer.id
  end

  def test_it_has_the_expected_initialized_first_name
    customer = Customer.new(data, nil)

    assert "Joey", customer.first_name
  end

  def test_it_has_the_expected_initialized_last_name
    customer = Customer.new(data, nil)

    assert "Ondricka", customer.last_name
  end

  def test_it_has_the_expected_initialized_created_at
    customer = Customer.new(data, nil)

    assert "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    customer = Customer.new(data, nil)

    assert "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_knows_its_repository
    repository = 'fake repository'
    assert_equal repository, Customer.new(data, repository).repository
  end
end