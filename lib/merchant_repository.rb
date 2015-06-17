require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :data_location,
              :parser,
              :merchants

  def initialize(data_location)
    @data_location = data_location
    @parser = MerchantParser.new(@data_location)
    @merchants = @parser.parse
  end
end
