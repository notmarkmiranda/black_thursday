module AnalystAssistant

  def items
    se.items
  end

  def merchants
    se.merchants
  end

  def invoices
    se.invoices
  end

  def all_merchants
    merchants.all
  end

  def items_by_merch_id(id)
    items.find_all_by_merchant_id(id)
  end

  def average_invoices_per_merchant
    invoices = all_merchants.map do |merchant|
      merchant.invoices.size.to_f
    end
    (invoices.reduce(:+)/invoices.size).round(2)
  end

end
