def double_odd_indices(arr)
  count = 0
  loop do
    break if count == arr.length
    arr[count] *= 2 if count % 2 != 0
    count += 1
  end
end
