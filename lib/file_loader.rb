require 'csv'
require 'bigdecimal'

class FileLoader
  def self.load_file(file_name)
    contents = CSV.open(file_name, headers: true, header_converters: :symbol)
  end
end
