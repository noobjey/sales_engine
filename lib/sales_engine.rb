require 'csv'
require './lib/merchant_repository'

class SalesEngine
  def startup

  end

  def merchant_repository
    MerchantRepository.new
  end
end

