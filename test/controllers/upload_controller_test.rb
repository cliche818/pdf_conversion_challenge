require 'test_helper'

class UploadControllerTest < ActionDispatch::IntegrationTest
  # test "saves the pdf and saves a record of the info collected" do
  #   file = Tempfile.new
  #   post "/upload", params: { email: "abc@gmail.com", file: file }
  #
  #   assert_equal 1, Invoice.count
  # end
  #

  # /document/:id

  test "returns json when given a invoice id" do
    invoice = Invoice.create(
      {
        vendor_name: "ABCDEF",
        invoice_date: Date.parse("March 25, 2020"),
        amount_due: 100.01,
        currency: 'CAD',
        tax_amount: 13.10,
        uploaded_by:  "fake@email.com",
        uploaded_at: Date.parse("March 25, 2020"),
        processing_status: "success"
      }
    )
    get "/document/#{invoice.id}"

    json = JSON.parse(response.body)

    assert_equal "ABCDEF", json["vendorName"]
    assert_equal "2020-03-25T00:00:00.000Z", json["invoiceDate"]
    assert_equal 100.01, json["amountDue"]
    assert_equal "CAD", json["currency"]
    assert_equal 13.1, json["taxAmount"]
    assert_equal "fake@email.com", json["uploadedBy"]
    assert_equal "2020-03-25T00:00:00.000Z", json["uploadTimestamp"]
    assert_equal "success", json["processingStatus"]
  end

  test "returns 400 error is invoice is not found" do
    get "/document/100"

    assert_response 400
  end
end
