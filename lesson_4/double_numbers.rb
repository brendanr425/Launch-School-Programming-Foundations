def double_numbers!(arr)
  counter = 0
  loop do
    break if counter == arr.length
    arr[counter] *= 2
    counter += 1
  end
  arr
end