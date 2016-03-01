require './lib/merchant'

class MerchantRepository
  attr_reader :repo, :all
  # @contents = CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol)
    def initialize(repo = [])
      @repo = repo
    end

    def all
      @repo.map { |key| [:id => key.id, :name=> key.name]}.flatten
    end

end
