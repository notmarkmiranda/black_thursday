require_relative 'test_helper'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_id_returns_the_invoice_item_id
    assert_equal 344, @ii.id
  end

  def test_id_item_id_returns_the_item_id
    assert_equal 263506360, @ii.item_id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 74, @ii.invoice_id
  end

  def test_unit_price_returns_the_unit_price
    result = (BigDecimal.new(87909) / BigDecimal.new(100))
    assert_equal result, @ii.unit_price
  end

  def test_created_at_returns_Time_instance_for_date_invoice_item_was_created
    time = Time.strptime("2012-03-27 14:54:13 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @ii.created_at
  end

  def test_updated_at_returns_Time_instance_for_date_invoice_was_last_updated
    time = Time.strptime("2012-03-27 14:54:13 UTC", "%Y-%m-%d %H:%M:%S %Z")
    assert_equal time, @ii.updated_at
  end
end
