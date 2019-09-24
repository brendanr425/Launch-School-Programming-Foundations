require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator.yml')

def prompt(message)
  puts "=> #{message}"
end

def clear
  system('clear') || system('cls')
end

loan_amt = nil
apr = nil
loan_duration_years = nil

loop do

  clear

  prompt(MESSAGES['welcome'])

  prompt(MESSAGES['loan_amount'])
  loop do
    loan_amt = gets.to_f
    break unless loan_amt == 0
    prompt(MESSAGES['invalid_input'])
  end

  clear

  prompt(MESSAGES['annual_percentage_rate'])
  loop do
    apr = (gets.to_f/100)
    break unless apr == 0
    prompt(MESSAGES['invalid_input'])
  end

  clear

  prompt(MESSAGES['loan_duration'])
  loop do
    loan_duration_years = gets.to_i
    break unless loan_duration_years == 0
    prompt(MESSAGES['invalid_input'])
  end

  clear

  loan_duration_months = loan_duration_years * 12
  monthly_rate = apr / loan_duration_months

  prompt(format(MESSAGES['monthly_interest'], interest: monthly_rate.round(3)))

  prompt(format(MESSAGES['loan_duration_months'], months: loan_duration_months))

  monthly_pay = loan_amt * (monthly_rate / (1 - ((1 + monthly_rate)**(-loan_duration_months))))

  prompt(format(MESSAGES['monthly_payment'], payment: monthly_pay.round(2)))

  prompt(MESSAGES['another_calculation'])
  answer = gets.chomp
  
  break if answer != 'y' && answer != 'Y'
end

clear

prompt(MESSAGES['thank_you'])















