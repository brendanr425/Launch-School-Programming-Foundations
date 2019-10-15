# The error occurs due to the concatenation of different data types. The expression '(40 + 2)' should either be interpolated or converted to a string prior to concatenation.

puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " + (40 + 2).to_s