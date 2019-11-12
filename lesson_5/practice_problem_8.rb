hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each_value do |v|
  v.each do |word|
    word.each_char{|letter| puts letter if 'aeiou'.include?(letter)}
  end
end