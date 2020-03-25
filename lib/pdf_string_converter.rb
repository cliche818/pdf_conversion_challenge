class PdfStringConverter
  def self.to_string(file_path)
    string = ''
    reader = PDF::Reader.new(file_path)

    reader.pages.each do |page|
      string += page.text
    end

    string
  end
end
