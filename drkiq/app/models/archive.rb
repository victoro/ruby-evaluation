require 'zip'
class Archive
    class << self
        def to_archive(file_name, zip_file_path)
            rename zip_file_path if File.exist?(zip_file_path)
            puts zip_file_path
            Zip::File.open(zip_file_path, create: true) do |zipfile|
                zipfile.add(zip_file_path, file_name)
            end
        end

        def rename(zip_file_path)
            new_zip_name = zip_file_path.gsub('.zip', sprintf("_%s", Time.now.strftime('%Y%m%d%H%M%S'))).concat('.zip')
            puts new_zip_name
            File::rename(zip_file_path, new_zip_name)
        end
    end
    
end
