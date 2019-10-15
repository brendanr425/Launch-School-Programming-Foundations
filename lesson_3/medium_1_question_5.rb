# The problem with Ben's code is that the 'limit' variable is defined outside the scope of the 'fib' method. This method can be fixed simply by defining the limit from within. 

def fib(first_num, second_num)
  limit = 15
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"