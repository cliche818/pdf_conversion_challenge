class InvoiceExtracter
  def self.to_invoice(invoice_string)
    index = invoice_string.index("Invoice")
    invoice = ValueObjects::Invoice.new

    truncated_invoice_string = invoice_string[index..-1]

    invoice_lines = truncated_invoice_string.split("\n")

    set_invoice_date!(invoice, invoice_lines)
    set_vendor!(invoice, invoice_lines)
    set_tax!(invoice, invoice_lines)
    # set_currency!(invoice, invoice_lines)

    invoice
  end

  private

  class << self
    private

    def set_invoice_date!(invoice, invoice_lines)
      invoice_date = invoice_lines[0].split("  ")[-1]
      invoice.invoice_date = invoice_date
    end

    def set_vendor!(invoice, invoice_lines)
      vendor = invoice_lines[3]
      invoice.vendor = vendor
    end

    def set_tax!(invoice, invoice_lines)
      tax_line_index = invoice_lines.index { |line| line.include?("Tax") }
      tax_amount = invoice_lines[tax_line_index].split(" ")[-1]
      invoice.tax = tax_amount
    end

    # def set_currency!(invoice, invoice_lines)
    #
    # end
  end
end