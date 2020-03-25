require 'test_helper'

class PdfStringConverterTest < ActiveSupport::TestCase
  test 'converts a pdf to its string interpretation (invoice 1)' do
    file_path = Rails.root.to_s + '/invoices/HubdocInvoice1.pdf'
    pdf_text = PdfStringConverter.to_string(file_path)

    expected_pdf_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_1.txt')

    assert_equal expected_pdf_text, pdf_text
  end

  test 'converts a pdf to its string interpretation (invoice 2)' do
    file_path = Rails.root.to_s + '/invoices/HubdocInvoice2.pdf'
    pdf_text = PdfStringConverter.to_string(file_path)

    expected_pdf_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_2.txt')

    assert_equal expected_pdf_text, pdf_text
  end

  test 'converts a pdf to its string interpretation (invoice 3)' do
    file_path = Rails.root.to_s + '/invoices/HubdocInvoice3.pdf'
    pdf_text = PdfStringConverter.to_string(file_path)

    expected_pdf_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_3.txt')

    assert_equal expected_pdf_text, pdf_text
  end

  test 'converts a pdf to its string interpretation (invoice 5)' do
    file_path = Rails.root.to_s + '/invoices/HubdocInvoice5.pdf'
    pdf_text = PdfStringConverter.to_string(file_path)

    expected_pdf_text = File.read(Rails.root.to_s + '/test/pdf_fixtures/hubdoc_invoice_5.txt')

    assert_equal expected_pdf_text, pdf_text
  end

  test "if file does not exist, return an empty string" do
    file_path = "does not exist path"
    pdf_text = PdfStringConverter.to_string(file_path)

    assert_equal "", pdf_text
  end
end
