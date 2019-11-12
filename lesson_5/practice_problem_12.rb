arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
arr.each_with_object({}){|arr, hash| hash[arr[0]] = arr[1]}