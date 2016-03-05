
class Customer
  attr_accessor :customer_data, :customer_repository

  def initialize(customer_data, customer_repository)
    @customer_data = customer_data
    @customer_repository = customer_repository
  end

  def id
    customer_data[0].to_i
  end

  def first_name
    customer_data[1]
  end

  def last_name
    customer_data[2]
  end

  def created_at
    Time.parse(customer_data[3])
  end

  def updated_at
    Time.parse(customer_data[4])
  end


end
