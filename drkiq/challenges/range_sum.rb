# https://www.codecademy.com/resources/blog/advanced-ruby-code-challenges/
# Write a function in Ruby that accepts two integers as arguments. 
# The function should sum all the integers from the lowest parameter to the highest one.
# For example, if the two arguments are 1 and 10, the function 
# should return 55, which is 1+2+3+4+5+6+7+8+9+10
require 'byebug'
class RangeSum
    attr_reader :sum

    def initialize(as_arr = false)
        @sum = 0
        @as_arr = as_arr
    end

    def get_input_range
        puts "Insert a number"
        number = STDIN.gets.chomp.to_i
        unless number.is_a?(Integer)
            puts "Input is not an integer"
            self.get_input_range
        end

        number
    end

    def do_sum(min, max, as_arr)

        puts "Executing sum between #{min} and #{max}"
        
        puts "Using sum with array functions #{as_arr}" if as_arr
        return @sum = [min..max].map(& :to_a).sum([]).sum if as_arr
        
        until (min > max)
            @sum += min
            min +=1
        end
        @sum
    end
    
end

range_sum = RangeSum.new()

a = range_sum.get_input_range
b = range_sum.get_input_range
min = [a, b].min
max = [a, b].max

puts range_sum.do_sum(min, max, !(ARGV.nil? || ARGV.empty?))
