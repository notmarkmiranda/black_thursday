require_relative 'customer'

class CustomerRepository

  def initialize(customers_data, engine)
    @engine = engine
    @customers = customers_data.map do |customer|
      Customer.new(customer, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id.to_i
    end
  end

  def find_all_by_first_name(name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def inspect
  "#<#{self.class} #{@customers.size} rows>"
  end


end
