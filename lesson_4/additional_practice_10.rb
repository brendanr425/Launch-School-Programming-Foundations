munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
}

munsters.each_val do |stats|
  if (0..17).cover?(stats['age'])
    stats['age_group'] = 'kid'
  elsif (18..64).cover?(stats['age'])
    stats['age_group'] = 'adult'
  else
    stats['age_group'] = 'senior'
  end
end