class LaboratoryResultFormatValue
    class << self
        @@test_results = [
            {:format => 'NEGATIVE', :value => -1.0},
            {:format => 'POSITIVE', :value => -2.0},
            {:format => 'NIL', :value => -1.0},
            {:format => '+', :value => -2.0},
            {:format => '++', :value => -2.0},
            {:format => '+++', :value => -3.0}
        ].freeze
    
        def value_of(format)
            item = @@test_results.find do |test_result_item|
                break test_result_item[:value] if test_result_item[:format] == format.to_s
            end
        end
    end
end
