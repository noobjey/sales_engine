require_relative "test_helper"
require_relative "../lib/sales_engine"
require_relative "../lib/merchant_repository"

class SalesEngineTest < Minitest::Test
  def test_it_creates_a_repository
    engine = SalesEngine.new("fake_data_path")

    engine.startup

    assert_equal true, engine.merchant_repository.is_a?(MerchantRepository)
  end

  def test_it_passes_itself_to_repository
    engine = SalesEngine.new("fake_data_path")

    engine.startup

    assert_equal engine, engine.merchant_repository.sales_engine
  end

  def test_it_loads_the_data
    engine = SalesEngine.new("../data")
    fake_merchant_repo = Minitest::Mock.new

    engine.merchant_repository = fake_merchant_repo
    fake_merchant_repo.expect(:load_data, 'somethinfg', ['../data/merchants.csv'])
    engine.startup

    fake_merchant_repo.verify
  end

  def test_it_stores_the_path_to_the_data
    engine = SalesEngine.new("../data")

    assert_equal "../data", engine.filepath
  end

  # def test_it_passes_itself_to_repository
  #   engine = SalesEngine.new
  #   fake_merchant_repo = Minitest::Mock.new
  #   engine.merchant_repository = fake_merchant_repo

  #   fake_merchant_repo.expect(:initialize, engine)
  #   engine.startup

  #   # assert_equal engine, engine.merchant_repository.sales_engine
  #   fake_merchant_repo.verify
  # end

  # repo has data
  # def test_it_creates_a_repository_and_fills_it_with_data
  # end
end

  # def test_it_can_talk_to_the_repository_with_items
  #   parent = Minitest::Mock.new
  #   merchant = Merchant.new(data, parent)
  #   parent.expect(:find_items, [1, 2], [1])
  #   assert_equal [1, 2], merchant.items
  #   parent.verify
  # end

  #   @mock.expect(:meaning_of_life, 42)
  #   @mock.meaning_of_life # => 42

  #   @mock.expect(:do_something_with, true, [some_obj, true])
  #   @mock.do_something_with(some_obj, true) # => true

  #   @mock.expect(:do_something_else, true) do |a1, a2|
  #     a1 == "buggs" && a2 == :bunny
  #   end