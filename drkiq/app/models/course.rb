require 'csv'
class Course < ApplicationRecord
    scope :month_older_course, -> {where(created_at: ..1.month.ago)}
    scope :not_updated_lately, -> {where(updated_at: ..10.days.ago)}
    scope :updated_lately, -> {where(updated_at: 10.days.ago..)}

    def self.to_csv(file_path)
        CSV.open(file_path, 'w', col_sep: '|') do |csv|
            csv << column_names
            all.each do |course|
                csv << course.attributes.values_at(*column_names)
            end
        end
        
    end
end
