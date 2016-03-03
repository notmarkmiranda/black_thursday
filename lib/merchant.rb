require_relative 'sales_engine'
require 'csv'

class Merchant
  attr_reader :id, :name, :items
  attr_accessor :repo

  def initialize(merchant, repo = nil, engine = nil)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @repo = repo
    @items = []
    @engine = engine
  end

  def items

    # @items = self.repo.engine.merchants.find_by_id(id).items
    #
    a = self.repo
    puts a
  end

  # look at the item repository
  # for your id
  # return all the items that are associated with that id

end
