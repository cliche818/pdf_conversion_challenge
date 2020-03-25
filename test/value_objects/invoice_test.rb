require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # convert_to_db_params
  test "converts the value object into a hash that can be saved to invoice activerecord" do
    invoice = ValueObjects::Invoice.new(vendor: "abc",
                              invoice_date: "March 13, 2019",
                              tax: "$1.63",
                              currency: "CAD",
                              invoice_amount: "$14.13")

    actual = invoice.convert_to_db_params
    expected = {
      vendor_name: "abc",
      invoice_date: Date.parse("March 13, 2019"),
      tax_amount: 1.63,
      currency: "CAD",
      amount_due: 14.13
    }

    assert_equal expected, actual
  end
end