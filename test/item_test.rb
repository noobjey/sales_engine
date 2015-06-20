require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id:          1,
      name:        "Item Qui Esse",
      description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price:  75107,
      merchant_id: 1,
      created_at:  "2012-03-27 14:53:59 UTC",
      updated_at:  "2012-03-27 14:53:59 UTC"
    }
  end

  def test_it_has_an_id
    assert_equal data[:id], Item.new(data).id
    end

  def test_it_has_a_name
    assert_equal data[:name], Item.new(data).name
  end

  def test_it_has_a_description
    assert_equal data[:description], Item.new(data).description
  end

  def test_it_has_a_unit_price
    assert_equal data[:unit_price], Item.new(data).unit_price
  end

  def test_it_has_a_merchant_id
    assert_equal data[:merchant_id], Item.new(data).merchant_id
  end

  def test_it_has_a_created_at_date
    assert_equal data[:created_at], Item.new(data).created_at
  end

  def test_it_has_a_updated_at_date
    assert_equal data[:updated_at], Item.new(data).updated_at
  end
end
