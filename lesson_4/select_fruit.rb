def select_fruit(produce)
  fruit = Hash.new
  produce.each do |key, val|
    fruit[key] = val if val == 'Fruit'
  end
  fruit
end