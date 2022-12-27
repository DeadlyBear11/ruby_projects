# Create class game
# Game welcomes the player
# Game has 6 colors.
# Game asks for player's guess.
# Game counts up to 12 player's guesses.
# Game checks if player's guess is right.
# Game ends if player's guesses > 12 or if player's guess is right.
# Create class computer
# Computer creates random 4 color code.
# Computer gives feedback on player's guess.
# Create class player
# Player tries to guess code.

class Game
  def initialize
    @turns = 12
    @colors = %w[red blue green yellow pink black]
    @win = false
    @turn = 1
  end

  attr_accessor :turns, :colors, :win, :turn

  def welcome
    puts '|==========================|'
    puts '|= Welcome to Mastermind! =|'
    puts '|==========================|'
  end

  def instr_player_guess
    puts 'Guess the 4 color code typing the names of the colors separated by commas.'
    puts 'The possible colors are red, blue, green, yellow, pink and black.'
  end

  def compare(code, guess)
    code == guess
  end

  def right_pos(code, guess)
    match = 0
    code.each_index { |i| match += 1 if code[i] == guess[i] }
    match
  end

  def included(code, guess, match)
    includes = 0
    guess.each { |g_color| includes +=1 if code.include?(g_color)}
    includes -= match
    includes
  end

  def feedback(code, guess)
    match = right_pos(code, guess)
    puts "Colors in the right position: #{match}."
    puts "Colors in the wrong position: #{included(code, guess, match)}."
  end

  def turns_loop(player, code)
    until win || turn > 12
      puts '___________________________________________________________'
      puts "This is turn number #{turn} out of 12."
      guess = player.take_guess
      @win = compare(code, guess)
      @turn += 1
      puts 'Congratulations! You win!' if win
      puts "I'm sorry, you ran out of guesses." if turn > 12
      feedback(code, guess) unless win || turn > 12
    end
  end
end

class Computer
  def initialize; end

  attr_accessor :code

  def create_code(game)
    @code = game.colors.sample(4)
    p @code
  end
end

class Player
  def initialize; end

  attr_accessor :guess

  def take_guess
    print 'Type your guess (Each color separated by a comma): '
    @guess = gets.chomp.gsub!(' ', '').split(',')
  end
end

game = Game.new
game.welcome
game.instr_player_guess
computer = Computer.new
code = computer.create_code(game)
player = Player.new
game.turns_loop(player, code)
