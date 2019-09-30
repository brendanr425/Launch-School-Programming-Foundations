require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator.yml')

def prompt(message)
  puts "=> #{message}"
end

def clear
  system('clear') || system('cls')
end

def retrieve_amount
  loop do
    amount = gets.to_f
    return amount unless amount <= 0
    clear
    prompt(MESSAGES['invalid_input'])
  end
end

def monthly_payment_calculation(loan_total, rate_by_month, loan_span_months)
  loan_total * (rate_by_month / (1 - ((1 + rate_by_month)**(-loan_span_months))))
end

loan_amt = nil
apr = nil
loan_duration_years = nil

loop do
  clear

  prompt(MESSAGES['welcome'])

  prompt(MESSAGES['loan_amount'])
  loan_amt = retrieve_amount

  clear

  prompt(MESSAGES['annual_percentage_rate'])
  apr = retrieve_amount / 100

  clear

  prompt(MESSAGES['loan_duration'])
  loan_duration_years = retrieve_amount

  clear

  loan_duration_months = loan_duration_years * 12
  monthly_rate = apr / loan_duration_months

  prompt(format(MESSAGES['monthly_interest'], interest: monthly_rate.round(3)))

  prompt(format(MESSAGES['loan_duration_months'], months: loan_duration_months.floor))

  monthly_pay = monthly_payment_calculation(loan_amt, monthly_rate, loan_duration_months)

  prompt(format(MESSAGES['monthly_payment'], payment: monthly_pay.round(2)))

  prompt(MESSAGES['another_calculation'])
  answer = gets.chomp
  
  break if answer != 'y' && answer != 'Y'
end

clear

prompt(MESSAGES['thank_you'])














