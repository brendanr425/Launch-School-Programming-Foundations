require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator.yml')

def prompt(message)
  puts "=> #{message}"
end

loop do
  prompt(MESSAGES['welcome'])

  prompt(MESSAGES['loan_amount'])
  loan_amt = gets.to_f

  prompt(MESSAGES['annual_percentage_rate'])
  apr = gets.to_f / 100

  prompt(MESSAGES['loan_duration'])
  loan_duration_y = gets.to_i

  loan_duration_m = loan_duration_y * 12
  m_rate = apr / loan_duration_m

  prompt(format(MESSAGES['monthly_interest'], interest: m_rate.round(3)))

  prompt(format(MESSAGES['loan_duration_months'], months: loan_duration_m))

  m_pay = loan_amt * (m_rate / (1 - (1 + m_rate)**(-loan_duration_m)))

  prompt(format(MESSAGES['monthly_payment'], payment: m_pay.round(2)))

  prompt(MESSAGES['another_calculation'])
  answer = gets.chomp

  break if answer != 'y' && answer != 'Y'
end

prompt(MESSAGES['thank_you'])















