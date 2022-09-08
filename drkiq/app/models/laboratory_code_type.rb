class LaboratoryCodeType
    class << self
        # try with hash
        @@code_types = [
            { :code => 'C100', :type => 'float'},
            { :code => 'C200', :type => 'float'},
            { :code => 'A250', :type => 'boolean'},
            { :code => 'B250', :type => 'nil_3plus'},
        ].freeze

        def type_of(code)
            @@code_types.find do |code_item|
                break code_item[:type].to_s if code_item[:code] == code.to_s
            end
        end
    end
end
