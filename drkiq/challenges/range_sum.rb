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
        return do_arr_sum(min, max) if as_arr
    
        puts "Executing basic iterative between #{min} and #{max}"
        until (min > max)
            @sum += min
            min +=1
        end
        @sum
    end

    def do_consecutive_sum(min, max)
        puts "Executing n(n+1)/2 sum between #{min} and #{max}"
        @sum = (max*(max+1))/2 - (min*(min-1))/2
    end
  
    def do_arr_sum(min, max)
        puts "Executing array sum between #{min} and #{max}"
        return @sum = [min..max].map(& :to_a).sum([]).sum
    end

end

range_sum = RangeSum.new()

a = range_sum.get_input_range
b = range_sum.get_input_range
min = [a, b].min
max = [a, b].max

puts range_sum.do_sum(min, max, !(ARGV.nil? || ARGV.empty?))
puts range_sum.do_consecutive_sum(min, max)
puts range_sum.do_arr_sum(min, max)