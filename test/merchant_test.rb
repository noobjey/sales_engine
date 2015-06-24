require_relative 'test_helper'
require_relative '../lib/merchant.rb'

class MerchantTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:         "1",
                name:       "Schroeder-Jerde",
                created_at: "2012-03-27 14:53:59 UTC",
                updated_at: "2012-03-27 14:53:59 UTC"
              }
  end

  def test_it_has_the_expected_initialized_id
    merchant = Merchant.new(data, nil)

    assert 1, merchant.id
  end

  def test_it_has_the_expected_initialized_first_name
    merchant = Merchant.new(data, nil)

    assert "Schroeder-Jerde", merchant.name
  end

  def test_it_has_the_expected_initialized_created_at
    merchant = Merchant.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    merchant = Merchant.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_has_items
    repo = Minitest::Mock.new
    merchant = Merchant.new(data, repo)

    repo.expect(:find_items, nil, [1])
    merchant.items

    repo.verify
  end

  def test_it_has_invoices
    repo = Minitest::Mock.new
    merchant = Merchant.new(data, repo)

    repo.expect(:find_invoices_by_id, nil, [data[:id].to_i])
    merchant.invoices

    repo.verify
  end
end
