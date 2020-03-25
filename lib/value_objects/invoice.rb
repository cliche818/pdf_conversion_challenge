module ValueObjects
  class Invoice < Struct.new(:vendor, :invoice_date, :invoice_amount, :currency, :tax, keyword_init: true)

    def convert_to_db_params
      {
        vendor_name: vendor,
        invoice_date: Date.parse(invoice_date),
        invoice_amount: invoice_amount[1..-1].to_f,
        currency: currency,
        tax_amount: tax[1..-1].to_f
      }
    end
  end
end
