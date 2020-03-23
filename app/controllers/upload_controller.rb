class UploadController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # can confirm sending curl -F 'file=@"invoices/HubdocInvoice1.pdf"' -F 'email=user@domain.com' localhost:3000/upload
    # see file in params[:file] and email in params[:email]
    file = params[:file]

    unless Dir.exist?(Rails.root.to_s + "/files_storage")
      FileUtils.mkdir(Rails.root.to_s + "/files_storage")
    end

    FileUtils.mv(file.tempfile.path, Rails.root.to_s + "/files_storage/#{file.original_filename}")

    render json: {}
  end
end
