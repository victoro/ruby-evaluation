require 'csv'
class ExportCsv
    class << self
        def courses_not_updated_lately
            courses = Course.month_older_course.not_updated_lately
            file_name = 'courses_not_updated_lately'
            file_path = sprintf("tmp/storage/%s.csv", file_name)
            courses.to_csv(file_path)
            archive_file(file_path, sprintf("tmp/storage/%s.zip", file_name))
        end

        def courses_updated_lately
            courses = Course.month_older_course.updated_lately
            file_name = 'courses_updated_lately'
            file_path = sprintf("tmp/storage/%s.csv", file_name)
            courses.to_csv(file_path)
            archive_file(file_path, sprintf("tmp/storage/%s.zip", file_name))
        end

        def archive_file(input, output, delete = true)
            Archive.to_archive(input, output)
            File.delete(input) if delete
        end
    end
end
