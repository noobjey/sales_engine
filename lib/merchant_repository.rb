require_relative 'merchant'
class MerchantRepository
  def merchants
    [Merchant.new]
  end
end
