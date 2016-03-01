require './lib/merchant'

class MerchantRepository
  attr_reader :repo, :all
  # @contents = CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol)
    def initialize(repo = [])
      @repo = repo
    end

    def all
      @repo.map { |key| [:id => key.id, :name => key.name]}.flatten
    end

    def find_by_id(id)
      @repo.find { |key| key.id == id }
    end

    def find_by_name(name)
      @repo.find { |key| key.name.downcase.include?(name.downcase) }
    end

    def find_all_by_name(name)
      @repo.find_all do |key|
        key.name.downcase.include?(name.downcase)
      end.map {|key| [:id => key.id, :name => key.name] }.flatten
    end
end
