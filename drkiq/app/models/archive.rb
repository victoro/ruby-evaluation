require 'zip'
class Archive
    class << self
        def to_archive(file_name, zip_file_path)
            Zip::File.open(zip_file_path, create: true) do |zipfile|
                zipfile.add(zip_file_path, file_name)
            end
        end
    end
    
end
