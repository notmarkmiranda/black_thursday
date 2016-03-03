require 'bigdecimal'
require 'csv'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :repo

  def initialize(item, repo = nil, engine = nil)
    @id = "#{Time.now.to_i}".chop.to_i
    @merchant_id = 0
    item.each do |key, value|
      send("#{key}=", value)
    end
    @repo = repo
    @engine = engine

  end
end
