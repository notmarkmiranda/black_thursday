require 'bigdecimal'
require 'csv'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(item)
    @id = 0 #need to write a method that will generate these two numbers
    @merchant_id = 1
    item.each do |key, value|
      send("#{key}=", value)
    end
    append_item_to_file
  end

  def append_item_to_file
    #before writing to file, some fields need to be converted to match the format of present entries.
    CSV.open("./data/items.csv", "a") do |csv|
      csv << ["#{id}", "#{name}", "#{description}", "#{unit_price}", "#{merchant_id}", "#{created_at}", "#{updated_at}"]
    end
  end

  #need to write a method that will change the value of updated_at.
  #run the method at the end of future methods that update an items info?

end
