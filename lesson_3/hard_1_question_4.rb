def an_ip_number?(num)
  (0..255).cover?(num.to_i)
end

def four_components?(ip)
  ip.split('.').length == 4
end

def dot_separated_ip_address?(input_string)
  return false unless !four_components?(input_string)
  input_string.split('.').each{|num| return false unless an_ip_number?(num)}
  return true
end

puts dot_separated_ip_address?('4.5.256.34')