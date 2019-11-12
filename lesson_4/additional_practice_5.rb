flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
answer = nil
flintstones.each_with_index{|name, idx| answer = idx if name[0..1] == 'Be'}
puts "The index is #{answer}!"