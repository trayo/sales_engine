require 'csv'

class FileLoader

  def self.load_file(file_name)
    file_name = file_name.insert(0, "data/")
    contents = CSV.open(file_name, headers: true, header_converters: :symbol)
  end

end
