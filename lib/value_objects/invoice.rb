module ValueObjects
  class Invoice
    attr_accessor :vendor, :invoice_date, :invoice_amount, :currency, :tax
  end
end
