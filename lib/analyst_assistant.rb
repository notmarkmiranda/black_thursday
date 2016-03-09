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

  def invoice_items
    se.invoice_items
  end

  def all_merchants
    merchants.all
  end

  def items_by_merch_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_ids
    all_merchants.map do |merch|
      merch.id
    end
  end

  def average_invoices_per_merchant # *
    invoices = all_merchants.map do |merchant|
      merchant.invoices.size.to_f
    end
    (invoices.reduce(:+)/invoices.size).round(2)
  end

  def merchants_ranked_by_revenue
    a = merchants.all.sort_by do |merch|
      merch.revenue if merch.revenue != nil
    end
    binding.pry
    # ids = all_merchants.map{ |merchant| merchant.id }
    # zipped = ids.map do |id|
    #   [revenue_by_merchant(id) || BigDecimal.new(0), merchants.find_by_id(id)]
    # end
    # ranked = zipped.sort_by{|pair| pair[0] }.reverse
    # ranked.map{ |pair| pair[1] }
  end

  def invoice_items_by_merchant(merch_id)
    @ii_objects = invoices.find_all_by_merchant_id(merch_id).map do |invoice|
      invoice
    end.reject do |invoice|
      invoice.all_failed_transactions?
    end.map do |invoice|
      invoice.id
    end.map do |num|
      invoice_items.find_all_by_invoice_id(num)
    end.flatten
  end

end
