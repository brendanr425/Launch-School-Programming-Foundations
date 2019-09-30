VALID_ANSWERS = %w(r p sc sp l)

def prompt(message)
  puts "=> #{message}"
end

def clear
  system('clear') || system('cls')
end

def display_choices(from_user, from_computer)
  abbreviations = { 'r' => 'rock',
                    'p' => 'paper',
                    'sc' => 'scissors',
                    'l' => 'lizard',
                    'sp' => 'spock' }
  "You chose #{abbreviations[from_user]} and the computer " \
  "chose #{abbreviations[from_computer]}."
end

def winner(choice1, choice2)
  winning_combinations = { 'r' => ['sc', 'l'],
                           'p' => ['r', 'sp'],
                           'sc' => ['p', 'l'],
                           'sp' => ['r', 'sc'],
                           'l' => ['sp', 'p'] }
  winning_combinations[choice1].include?(choice2)
end

user_choice = ''
play_again = ''

clear

prompt("Welcome to Rock Paper Scissors Spock Lizard!")

loop do
  user_wins = 0
  computer_wins = 0
  loop do
    loop do
      prompt("Type 'R' for rock, 'P' for paper, 'Sc' for scissors, " \
             "'L' for lizard, or 'Sp' for spock:")
      user_choice = gets.chomp.downcase

      if VALID_ANSWERS.include?(user_choice)
        break
      end

      clear
      prompt("Invalid input. Try again!")
      prompt("You: #{user_wins} | Computer: #{computer_wins}")
    end

    computer_choice = VALID_ANSWERS.sample.downcase
    puts

    clear

    if winner(user_choice, computer_choice)
      prompt("#{display_choices(user_choice, computer_choice)} You win!")
      user_wins += 1
    elsif winner(computer_choice, user_choice)
      prompt("#{display_choices(user_choice, computer_choice)} You lose.")
      computer_wins += 1
    else
      prompt("#{display_choices(user_choice, computer_choice)} It's a tie!")
    end

    prompt("You: #{user_wins} | Computer: #{computer_wins}")

    break if user_wins == 5 || computer_wins == 5
  end

  if user_wins == 5
    prompt("Congratulations! You've won five rounds of RPSLS!")
  else
    prompt("You've lost five rounds of RPSLS.")
  end

  loop do
    prompt("Press 'Y' to play again or 'N' to exit.")
    play_again = gets.chomp
    clear
    break if play_again.downcase == 'n' || play_again.downcase == 'y'
    prompt("Invalid input.")
  end

  break if play_again.downcase == 'n'
end

clear

prompt("Thank you for playing!")
