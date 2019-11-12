require 'pry'

def starting_deck(deck, suits)
  [deck[random_suit = suits.sample].delete(deck[random_suit].sample),
   deck[random_suit = suits.sample].delete(deck[random_suit].sample)]
end

def hit(deck, suits)
  deck[random_suit = suits.sample].delete(deck[random_suit].sample)
end

def hit_or_stay?(user_deck, deck, suits)
  puts 'hit or stay?'
  answer = gets.chomp
  if answer.casecmp?('hit')
    user_deck << hit(deck, suits)
  elsif answer.casecmp?('stay')
    'break'
  else
    puts 'Invalid input. Try again!'
  end
end

def end_results(user_deck, comp_deck)
  if convert_to_values(user_deck).sum >
     convert_to_values(comp_deck).sum
    puts 'You win!'
  elsif convert_to_values(user_deck).sum <
        convert_to_values(comp_deck).sum
    puts 'You lose...'
  else
    puts "It's a tie!"
  end
end

def play_again?
  puts "Play again? ('y' or any other key to exit.)"
  answer = gets.chomp
  answer
end

def convert_to_keys(deck)
  deck.map do |ele|
    if ele.class == Hash
      ele.keys[0]
    else
      ele
    end
  end
end

def display_totals(user_deck, comp_deck)
  puts
  puts "Player total: #{convert_to_values(user_deck).sum}"
  puts "Dealer total: #{convert_to_values(comp_deck).sum}"
  puts
end

def ace_conversion(deck)
  deck.map! do |ele|
    if ele.class == Hash && ele.keys[0] == 'ace'
      { 'ace' => 1 }
    else
      ele
    end
  end
end

def convert_to_values(deck)
  deck.map do |ele|
    if ele.class == Hash
      ele.values[0]
    else
      ele
    end
  end
end

def dealer_turn(deck, computer_deck, suits)
  until convert_to_values(computer_deck).sum >= 17
    computer_deck << hit(deck, suits)
    ace_conversion(computer_deck) if convert_to_values(computer_deck).sum > 21
  end
  computer_deck
end

def print_decks(user_deck, comp_deck)
  user_dup = convert_to_keys(user_deck)
  computer_dup = convert_to_keys(comp_deck)

  if user_dup.length == 2
    puts "You have: #{user_dup.join(' and ')}."
  else
    puts "You have: #{user_dup[0..-2].join(', ')}, and #{user_dup[-1]}."
  end

  puts "Dealer has: #{computer_dup[0]} and unknown card."
end

def print_user_deck(user_deck)
  user_dup = convert_to_keys(user_deck)

  if user_dup.length == 2
    puts "You have: #{user_dup.join(' and ')}."
  else
    puts "You have: #{user_dup[0..-2].join(', ')}, and #{user_dup[-1]}."
  end
end

def print_dealer_deck(comp_deck)
  comp_dup = convert_to_keys(comp_deck)

  if comp_dup.length == 2
    puts "Dealer has: #{comp_dup.join(' and ')}."
  else
    puts "Dealer has: #{comp_dup[0..-2].join(', ')}, and #{comp_dup[-1]}."
  end
end

def deck_and_total(user_deck, comp_deck)
  print_user_deck(user_deck)
  print_dealer_deck(comp_deck)
  display_totals(user_deck, comp_deck)
end

def busted?(deck)
  convert_to_values(deck).sum > 21
end

def clear
  system('cls') || system('clear')
end

deck = {}
suits = %w(hearts spades clubs diamonds)
suits.each do |suit|
  deck[suit] = [2, 3, 4, 5, 6, 7, 8, 9, 10,
                { 'jack' => 10 }, { 'queen' => 10 },
                { 'king' => 10 }, { 'ace' => 11 }]
end

loop do
  player_deck = starting_deck(deck, suits)
  dealer_deck = starting_deck(deck, suits)
  loop do
    clear
    print_decks(player_deck, dealer_deck)
    option = hit_or_stay?(player_deck, deck, suits)

    ace_conversion(player_deck) if convert_to_values(player_deck).sum > 21

    break if busted?(player_deck) || option == 'break'
  end

  clear

  if busted?(player_deck)
    puts "You've busted. You lose."
  else
    puts 'You chose to stay...'
    puts

    dealer_deck = dealer_turn(deck, dealer_deck, suits)

    if busted?(dealer_deck)
      puts 'The dealer has busted. You win!'
    else
      end_results(player_deck, dealer_deck)
    end
  end

  deck_and_total(player_deck, dealer_deck)
  break unless play_again?.casecmp?('y')
end

clear
puts 'Thank you for playing!'
