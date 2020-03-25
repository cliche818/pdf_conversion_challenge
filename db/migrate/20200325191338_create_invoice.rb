class CreateInvoice < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :uploaded_by
      t.datetime :uploaded_at
      t.integer :filesize
      t.string :vendor_name
      t.datetime :invoice_date
      t.float :amount_due
      t.string :currency
      t.float :tax_amount
      t.string :processing_status
      t.string :file_path

      t.timestamps
    end
  end
end
