def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Bonus 1: The purpose of the expression 'number % divisor == 0' is to ensure that there's no remainder when taking the quotient of these two numbers. This confirms that the divsor is a factor of the given number. 

# Bonus 2: The last line before the method's end will return the array of factors. 