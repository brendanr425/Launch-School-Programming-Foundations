statement = "The Flintstones Rock"
letter_count = Hash.new(0)
statement.each_char{|letter| letter_count[letter] += 1}
