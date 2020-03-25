require 'test_helper'

class PdfStringConverterTest < ActiveSupport::TestCase
  test 'converts a pdf to its string interpretation' do
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
