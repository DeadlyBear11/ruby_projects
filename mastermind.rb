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
  end

  attr_accessor :turns, :colors

  def welcome
    puts '|==========================|'
    puts '|= Welcome to Mastermind! =|'
    puts '|==========================|'
  end

  def instr_player_guess
    puts 'Guess the 4 color code typing the names of the colors separated by commas.'
    puts 'The possible colors are red, blue, green, yellow, pink and black.'
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
    print 'Type your your guess (Each color separated by a comma): '
    @guess = gets.chomp.gsub!(' ', '').split(',')
    p @guess
  end
end

game = Game.new
game.welcome
game.instr_player_guess
computer = Computer.new
computer.create_code(game)
player = Player.new
player.take_guess
