# ask the user for two numbers
# ask the user for  an operation to perform
# perform the operation on the two numbers
# output the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')  

def prompt(message)
  Kernel.puts("=> #{message}") 
end

def valid_number?(number)
  integers = %w(. 0 1 2 3 4 5 6 7 8 9)
  bool = true

  number.each_char do |char|
    if integers.include?(char) == false
      bool = false
      break
    end
  end
  
  bool
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt(MESSAGES['welcome'])
name = ''

loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt(format(MESSAGES['greeting'], name: name))

loop do

  number1 = ''
  number2 = ''
  operator = ''

  loop do
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets().chomp() 

    if valid_number?(number1) 
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets().chomp() 

    if valid_number?(number2) 
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
    
  prompt(operator_prompt)
  
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['choices'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")
  result = case operator
           when '1'
            number1.to_i() + number2.to_i()
           when '2'
            number1.to_i() - number2.to_i()
           when '3'
            number1.to_i() * number2.to_i()
           when '4'
            number1.to_f() / number2.to_f()
  end

  prompt("The result is #{result}")

  prompt(MESSAGES['another_calculation'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['farewell'])