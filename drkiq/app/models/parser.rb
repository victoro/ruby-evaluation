require 'csv'
class Parser

    attr_accessor :results, :parsed_line

    @@obx_line = ['id', 'code', 'format'].freeze
    @@nte_line = ['id', 'comment'].freeze

    def initialize(file_path)
        @results = []
        @parsed_line = {}
        raise sprintf("File does not exist %s", file_path) unless File.exist?(file_path)
        
        # code = 'C100'
        # result = LaboratoryCodeType.type_of(code)
        # format = LaboratoryResultFormatValue.value_of('++')
        # comment = 'comment'
        # results << LaboratoryTestResult.new(code, result, format, comment)

        # code = 'C200'
        # result = LaboratoryCodeType.type_of(code)
        # format = LaboratoryResultFormatValue.value_of('++')
        # comment = 'comment'
        # results << LaboratoryTestResult.new(code, result, format, comment)
        
        File.foreach(file_path) do |line|
            parsed_data = parse line unless line.empty?
            parsed_data.each do |id, lab_results|
                unless invalid? lab_results
                    save lab_results
                    parsed_data.delete(id.to_s)
                end
            end
        end
    end

    def mapped_results
        @results ||= []
    end

    # private
    def parse(line)
        line_arr_data = line.split('|')
        obx_data = parse_obx(line_arr_data) if line_arr_data.include?('OBX')
        nte_data = parse_nte(line_arr_data) if line_arr_data.include?('NTE')

        unless obx_data.nil? || obx_data[:id].nil?
            if parsed_line[obx_data[:id]]
                @parsed_line[obx_data[:id]].merge!(obx_data)
            else
                @parsed_line[obx_data[:id]] = obx_data
            end
        end
        unless nte_data.nil? || nte_data[:id].nil?
            if parsed_line[nte_data[:id]]
                @parsed_line[nte_data[:id]].merge!(nte_data)
            else
                @parsed_line[nte_data[:id]] = nte_data
            end
        end
        puts "============== start parsed line =================="
        puts @parsed_line
        puts "================ end parsed line ================"
        @parsed_line
    end

    def parse_obx(line_arr_data)
        index = line_arr_data.index 'OBX'
        type_data = line_arr_data.slice(index+1, 3) unless line_arr_data[index+1].nil?
        @@obx_line.map(& :to_sym).zip(type_data).to_h
    end

    def parse_nte(line_arr_data)
        index = line_arr_data.index 'NTE'
        type_data = line_arr_data.slice(index+1, 2) unless line_arr_data[index+1].nil?
        @@nte_line.map(& :to_sym).zip(type_data).to_h
    end
   
    def save(lab_results)
        puts "================================"
        puts lab_results
        puts "================================"
        result = LaboratoryCodeType.type_of(lab_results[:code])
        format = LaboratoryResultFormatValue.value_of(lab_results[:format]) || lab_results[:format].to_f unless lab_results[:format].nil?
        comment = lab_results[:comment].to_s || ""
        @results << LaboratoryTestResult.new(lab_results[:code].to_s, result, format, comment)
    end

    def invalid?(lab_results)
        lab_results[:code].nil? || lab_results[:format].nil? || lab_results[:comment].nil?
    end

end
