class UploadController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    file = params[:file]

    unless Dir.exist?(Rails.root.to_s + "/files_storage")
      FileUtils.mkdir(Rails.root.to_s + "/files_storage")
    end

    file_size = file.tempfile.size
    file_path = Rails.root.to_s + "/files_storage/#{file.original_filename}"

    FileUtils.mv(file.tempfile.path, file_path)

    invoice_str = PdfStringConverter.to_string(file_path)
    invoice_obj = InvoiceExtracter.to_invoice(invoice_str)
    invoice_params = invoice_obj.convert_to_db_params

    record = Invoice.new({
                           uploaded_at: Time.now.utc.iso8601,
                           uploaded_by: params[:email],
                           filesize: file_size,
                           processing_status: "success",
                           file_path: file_path
                         }.merge(invoice_params)
    )


    if record.save
      render json: { id: record.id }
    else
      render json: {}, status: 400
    end
  end
end
