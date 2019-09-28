VALID_ANSWERS = %w(r p sc sp l)

def prompt(message)
  puts "=> #{message}"
end

def clear
  system('clear') || system('cls')
end

def winner(choice_1, choice_2)
  winning_combinations = {'r' => ['sc', 'l'], 
                          'p' => ['r', 'sp'],
                          'sc'=> ['p', 'l'],
                          'sp'=> ['r', 'sc'],
                          'l' => ['sp', 'p'],
                         }
  return true if winning_combinations[choice_1].include?(choice_2)
  return false
end

user_choice = ''

abbreviations = {'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'l' => 'lizard', 'sp' => 'spock'}

clear

prompt("Welcome to Rock Paper Scissors Spock Lizard!")

loop do
  user_wins = 0
  computer_wins = 0
  loop do
    loop do
      prompt("Type 'R' for rock, 'P' for paper, 'Sc' for scissors, 'L' for lizard, or 'Sp' for spock:")
      user_choice = gets.chomp.downcase

      if VALID_ANSWERS.include?(user_choice) == true
        break
      end
      clear
      prompt("Invalid input. Try again!")
      prompt("You: #{user_wins} | Computer: #{computer_wins}")
    end

    computer_choice = VALID_ANSWERS.sample.downcase
    puts

    clear

    if winner(user_choice, computer_choice) == true
      prompt("You chose #{abbreviations[user_choice]} and the computer chose #{abbreviations[computer_choice]}. You win!")
      user_wins += 1
      prompt("You: #{user_wins} | Computer: #{computer_wins}")
    elsif winner(computer_choice, user_choice) == true
      prompt("You chose #{abbreviations[user_choice]} and the computer chose #{abbreviations[computer_choice]}. You lose.")
      computer_wins += 1
      prompt("You: #{user_wins} | Computer: #{computer_wins}")
    else
      prompt("You chose #{abbreviations[user_choice]} and the computer chose #{abbreviations[computer_choice]}. It's a tie!")
      prompt("You: #{user_wins} | Computer: #{computer_wins}")
    end

    break if user_wins == 5 || computer_wins == 5
  end

  if user_wins == 5
    prompt("Congratulations! You've won five rounds of RPSLS!")
  else
    prompt("You've lost five rounds of RPSLS.")
  end

  prompt("Press 'Y' to play again or any other key to exit.")

  play_again = gets.chomp

  clear

  break if play_again.downcase != 'y'
end

clear

prompt("Thank you for playing!")

  



