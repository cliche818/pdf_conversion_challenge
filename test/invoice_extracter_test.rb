require 'test_helper'

class InvoiceExtracterTest < ActiveSupport::TestCase
  test "turns text into invoice value objects" do
    invoice_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_1.txt')
    invoice = InvoiceExtracter.to_invoice(invoice_text)

    assert_equal "UK Company", invoice.vendor
    assert_equal "February 22, 2019", invoice.invoice_date
    assert_equal "£0.00", invoice.tax
    assert_equal "GBP", invoice.currency

  end
end