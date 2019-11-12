def multiply(arr, number)
  count = 0
  loop do
    break if count == arr.length
    arr[count] *= number
    count += 1
  end
  arr  
end