class PdfStringConverter
  def self.to_string(file_path)
    string = ''

    if File.exist?(file_path)
      reader = PDF::Reader.new(file_path)

      reader.pages.each do |page|
        string += page.text
      end
    end

    string
  end
end
