def uuid
  start_point = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
  final_value = start_point.split('-')
  hex = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

  final_value.map do |section|
    section.each_char.with_index do |char, idx|
      section[idx] = hex.sample
    end
  end.join('-')
end