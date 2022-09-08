namespace :custom_tasks do
    desc 'Custom tasks holder'
    namespace :parse do
        desc "'Test to parse csv file https://gist.github.com/rodrigofhm/d7b8c38ef966250160ed71ce59a7822c"
        task :csv => :environment do
            unless ARGV.empty?
                puts "Filename not provided as argument" if ARGV[1].nil?
                file_name = ARGV[1] unless ARGV[1].nil?
            end
            if file_name.nil?
                puts "Enter file name"
                file_name = STDIN.gets.chomp
            end
            
            file_name = [file_name.to_s, 'csv'].join('.') unless file_name.empty?

            begin  
                file_path = sprintf("tmp/storage/%s", file_name) unless file_name.nil?
                puts sprintf("Processing file %s", file_path.to_s)
                parser = Parser.new(file_path)
                puts parser.mapped_results.inspect
            rescue => exception
                puts exception.message
                puts exception.backtrace.inspect
            end
            
            exit!
        end
    end
    
end