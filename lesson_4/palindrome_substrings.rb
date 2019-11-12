def palindrome?(string)
  string.reverse == string && string.length > 1
end

def palindrome_substrings(str)
  substring = []
  first = 0
  last = 0
  while first < str.length
    while last < str.length
      substring << str[first, last] if is_palindrome(str[first, last])
      last += 1
    end
    first += 1
    last = 0
  end
  substring
end