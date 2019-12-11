def ace_conversion(deck)
  deck.each_with_index do |_, idx|
    if total(deck[0..idx]) > 21 &&
       convert_to_keys(deck).include?('ace' => 11)

      deck[convert_to_keys(deck).index('ace' => 11)] =
        { { 'ace' => 1 } =>
        convert_to_suits(deck)[convert_to_keys(deck).index('ace' => 11)] }
    else
      next
    end
  end
end

def busted?(deck)
  total(deck) > 21
end

def clear
  system('cls') || system('clear')
end

def convert_to_keys(deck)
  deck.map do |card|
    if card.class == Hash
      card.keys[0]
    else
      card
    end
  end
end

def convert_to_suits(deck)
  deck.map { |card| card.values[0] }
end

def convert_to_values(deck)
  deck.map do |card|
    if card.keys[0].class == Hash
      card.keys[0].values[0]
    else
      card.keys[0]
    end
  end
end

def dealer_turn(deck, computer_deck, suits)
  ace_conversion(computer_deck)
  until total(computer_deck) >= 17
    computer_deck << hit(deck, suits)
    ace_conversion(computer_deck)
  end
  computer_deck
end

def print_decks_and_totals(user_deck, comp_deck)
  print_user_deck(user_deck)
  print_dealer_deck(comp_deck)
  display_totals(user_deck, comp_deck)
end

def display_totals(user_deck, comp_deck)
  puts
  puts "Player total: #{total(user_deck)}"
  puts "Dealer total: #{total(comp_deck)}"
end

def display_wins(user_wins, computer_wins)
  puts 'You have won 1 round.' if user_wins == 1
  puts "You have won #{user_wins} rounds." if user_wins != 1
  puts 'The dealer has won 1 round.' if computer_wins == 1
  puts "The dealer has won #{computer_wins} rounds." if computer_wins != 1
end

def end_results(user_deck, comp_deck)
  if total(user_deck) > total(comp_deck)
    puts 'You win!'
  elsif total(user_deck) < total(comp_deck)
    puts 'You lose...'
  else
    puts "It's a tie!"
  end
end

def hit(deck, suits)
  { deck[random_suit = suits.sample].delete(deck[random_suit].sample) =>
    random_suit }
end

def hit_or_stay?(user_deck, deck, suits)
  puts 'hit or stay?'
  answer = gets.chomp
  if answer.casecmp?('h')
    user_deck << hit(deck, suits)
  elsif answer.casecmp?('s')
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

# rubocop: disable Metrics/MethodLength
def introduction
  clear
  puts "Welcome to Twenty One! Here are the rules of the game: \n"
  puts "\n- You and the dealer will start with two cards randomly
  selected from the 52-card deck. \n"
  puts "\n- If you decide to hit, type 'h'. This will result in
  drawing another random card into your hand. If the sum of
  all the cards in your hand exceeds 21, you lose. \n"

  puts "\n- If you decide to stay, type 's'. This will end your turn
  and start the dealer's. \n"

  puts "\n- By the end of both players' turns, the player with the hand
  that has the greater sum of values wins. \n"

  puts "\nPress 'ENTER' to continue!"
  gets.chomp
end
# rubocop: enable Metrics/MethodLength

def play_again?
  puts "Play again? (Enter 'y' or simply press 'ENTER' to exit.)"
  answer = gets.chomp
  answer
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

def print_dealer_deck(comp_deck)
  comp_dup = suit_and_value(comp_deck)

  if comp_dup.length == 2
    puts "Dealer has: #{comp_dup.join(' and ')}."
  else
    puts "Dealer has: #{comp_dup[0..-2].join(', ')}, and #{comp_dup[-1]}."
  end
end

def print_decks(user_deck, comp_deck)
  print_user_deck(user_deck)
  print_dealer_deck(comp_deck)
end

def print_user_deck(user_deck)
  user_dup = suit_and_value(user_deck)

  if user_dup.length == 2
    puts "You have: #{user_dup.join(' and ')}."
  else
    puts "You have: #{user_dup[0..-2].join(', ')}, and #{user_dup[-1]}."
  end
end

def round(wins, deck1, deck2)
  wins += 1 if total(deck1) > total(deck2)
  wins
end

def starting_hand(deck, suits)
  [hit(deck, suits), hit(deck, suits)]
end

# rubocop: disable Metrics/AbcSize

def suit_and_value(deck)
  deck.map do |card|
    if card.keys[0].class == Hash
      "#{card.keys[0].keys[0]} of #{card.values[0]}"
    else
      "#{card.keys[0]} of #{card.values[0]}"
    end
  end
end

# rubocop: enable Metrics/AbcSize

def total(deck)
  convert_to_values(deck).sum
end

def total_and_wins(user_hand, comp_hand, user_wins, comp_wins)
  puts
  print_decks_and_totals(user_hand, comp_hand)
  puts
  display_wins(user_wins, comp_wins)
  puts
  puts "Press 'ENTER' for the next round!" if user_wins < 5 && comp_wins < 5
  puts "Press 'ENTER' to continue!" if user_wins == 5 || comp_wins == 5
  gets.chomp
end

suits = %w(hearts spades clubs diamonds)

# rubocop: disable Metrics/BlockLength

loop do
  introduction
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
        player_wins = round(player_wins, player_hand, dealer_hand)
        dealer_wins = round(dealer_wins, dealer_hand, player_hand)
      end
    end

    total_and_wins(player_hand, dealer_hand, player_wins, dealer_wins)
  end
  break unless play_again?.casecmp?('y')
end

# rubocop: enable Metrics/BlockLength

clear
puts 'Thank you for playing!'
