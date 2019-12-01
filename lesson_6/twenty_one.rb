def ace_conversion(deck)
  deck.each_with_index do |_, idx|
    if convert_to_values(deck[0..idx]).sum > 21 && deck.include?('ace' => 11)
      deck[deck.index('ace' => 11)] = { 'ace' => 1 }
    end
  end
end

def busted?(deck)
  convert_to_values(deck).sum > 21
end

def clear
  system('cls') || system('clear')
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

def convert_to_values(deck)
  deck.map do |ele|
    if ele.class == Hash
      ele.values[0]
    else
      ele
    end
  end
end

def dealer_round(wins, user_deck, comp_deck)
  if convert_to_values(user_deck).sum < convert_to_values(comp_deck).sum
    wins += 1
  end
  wins
end

def dealer_turn(deck, computer_deck, suits)
  until convert_to_values(computer_deck).sum >= 17
    computer_deck << hit(deck, suits)
    ace_conversion(computer_deck) if convert_to_values(computer_deck).sum > 21
  end
  computer_deck
end

def deck_and_total(user_deck, comp_deck)
  print_user_deck(user_deck)
  print_dealer_deck(comp_deck)
  display_totals(user_deck, comp_deck)
end

def display_totals(user_deck, comp_deck)
  puts
  puts "Player total: #{convert_to_values(user_deck).sum}"
  puts "Dealer total: #{convert_to_values(comp_deck).sum}"
end

def display_wins(user_wins, computer_wins)
  puts 'You have won 1 round.' if user_wins == 1
  puts "You have won #{user_wins} rounds." if user_wins != 1
  puts 'The dealer has won 1 round.' if computer_wins == 1
  puts "The dealer has won #{computer_wins} rounds." if computer_wins != 1
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
    puts "Invalid input. Try again! (Press 'ENTER' to continue!)"
    gets.chomp
  end
end

def initialize_deck(suits)
  deck = {}
  suits.each do |suit|
    deck[suit] = [2, 3, 4, 5, 6, 7, 8, 9, 10,
                  { 'jack' => 10 }, { 'queen' => 10 },
                  { 'king' => 10 }, { 'ace' => 11 }]
  end
  deck
end

def play_again?
  puts "Play again? (Enter 'y' or simply press 'ENTER' to exit.)"
  answer = gets.chomp
  answer
end

def player_round(wins, user_deck, comp_deck)
  if convert_to_values(user_deck).sum > convert_to_values(comp_deck).sum
    wins += 1
  end
  wins
end

def print_dealer_deck(comp_deck)
  comp_dup = convert_to_keys(comp_deck)

  if comp_dup.length == 2
    puts "Dealer has: #{comp_dup.join(' and ')}."
  else
    puts "Dealer has: #{comp_dup[0..-2].join(', ')}, and #{comp_dup[-1]}."
  end
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

def total_and_wins(user_hand, comp_hand, user_wins, comp_wins)
  puts
  deck_and_total(user_hand, comp_hand)
  puts
  display_wins(user_wins, comp_wins)
  puts
  puts "Press 'ENTER' for the next round!" if user_wins < 5 && comp_wins < 5
  puts "Press 'ENTER' to continue!" if user_wins == 5 || comp_wins == 5
  gets.chomp
end

def print_user_deck(user_deck)
  user_dup = convert_to_keys(user_deck)

  if user_dup.length == 2
    puts "You have: #{user_dup.join(' and ')}."
  else
    puts "You have: #{user_dup[0..-2].join(', ')}, and #{user_dup[-1]}."
  end
end

def player_turn(player_hand, dealer_hand, deck, suits)
  loop do
    clear
    print_decks(player_hand, dealer_hand)
    option = hit_or_stay?(player_hand, deck, suits)

    ace_conversion(player_hand)

    break if busted?(player_hand) || option == 'break'
  end
end

def starting_hand(deck, suits)
  [deck[random_suit = suits.sample].delete(deck[random_suit].sample),
   deck[random_suit = suits.sample].delete(deck[random_suit].sample)]
end

suits = %w(hearts spades clubs diamonds)

# rubocop: disable Metrics/BlockLength
loop do
  player_wins = 0
  dealer_wins = 0
  until player_wins == 5 || dealer_wins == 5
    deck = initialize_deck(suits)
    player_hand = starting_hand(deck, suits)
    dealer_hand = starting_hand(deck, suits)

    player_turn(player_hand, dealer_hand, deck, suits)

    clear

    if busted?(player_hand)
      puts "You've busted. You lose."
      dealer_wins += 1
    else
      puts 'You chose to stay...'
      puts

      dealer_hand = dealer_turn(deck, dealer_hand, suits)

      if busted?(dealer_hand)
        puts 'The dealer has busted. You win!'
        player_wins += 1
      else
        end_results(player_hand, dealer_hand)
        player_wins = player_round(player_wins, player_hand, dealer_hand)
        dealer_wins = dealer_round(dealer_wins, player_hand, dealer_hand)
      end
    end

    total_and_wins(player_hand, dealer_hand, player_wins, dealer_wins)
  end
  break unless play_again?.casecmp?('y')
end

clear
puts 'Thank you for playing!'
