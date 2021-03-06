require 'test_helper'

class InvoiceExtracterTest < ActiveSupport::TestCase
  test "turns text into invoice value objects for hubdoc_invoice_1.txt" do
    invoice_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_1.txt')
    invoice = InvoiceExtracter.to_invoice(invoice_text)

    assert_equal "UK Company", invoice.vendor
    assert_equal "February 22, 2019", invoice.invoice_date
    assert_equal "£0.00", invoice.tax
    assert_equal "GBP", invoice.currency
    assert_equal "£22.50", invoice.invoice_amount
  end

  test "turns text into invoice value objects for hubdoc_invoice_2.txt" do
    invoice_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_2.txt')
    invoice = InvoiceExtracter.to_invoice(invoice_text)

    assert_equal "Alan Free", invoice.vendor
    assert_equal "March 12, 2019", invoice.invoice_date
    assert_equal "$0.00", invoice.tax
    assert_equal "USD", invoice.currency
    assert_equal "$40.00", invoice.invoice_amount
  end

  test "turns text into invoice value objects for hubdoc_invoice_3.txt" do
    invoice_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_3.txt')
    invoice = InvoiceExtracter.to_invoice(invoice_text)

    assert_equal "canadian", invoice.vendor
    assert_equal "March 13, 2019", invoice.invoice_date
    assert_equal "$1.63", invoice.tax
    assert_equal "CAD", invoice.currency
    assert_equal "$14.13", invoice.invoice_amount
  end

  test "turns text into invoice value objects for hubdoc_invoice_5.txt" do
    invoice_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_5.txt')
    invoice = InvoiceExtracter.to_invoice(invoice_text)

    assert_equal "The Company", invoice.vendor
    assert_equal "March 18, 2019", invoice.invoice_date
    assert_equal "$13.65", invoice.tax
    assert_equal "CAD", invoice.currency
    assert_equal "$118.65", invoice.invoice_amount
  end
end