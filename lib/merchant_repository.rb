require './lib/merchant'

class MerchantRepository
  attr_reader :merchant, :all
  # @contents = CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol)
    def initialize(merchant = [])
      @merchant = merchant
      @all = merchant
    end

    def find_size
      @merchant.size
    end
    
    def find_by_id(id)
      @merchant.find { |key| key.id == id }
    end

    def find_by_name(name)
      @merchant.find { |key| key.name.downcase.include?(name.downcase) }
    end

    def find_all_by_name(name)
      @merchant.find_all do |key|
        key.name.downcase.include?(name.downcase)
      end
    end
end
