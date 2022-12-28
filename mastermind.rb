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

require 'pry-byebug'

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
    match = []
    code.each_index do |i|
      match.push(code[i]) if code[i] == guess[i]
    end
    puts "Match: #{match}."
    match
  end

  def wrong_pos(code, guess, match)
    new_code = []
    new_guess = []
    code.each { |c_color| new_code.push(c_color) }
    guess.each { |g_color| new_guess.push(g_color) }

    match.each do |m_color|
      new_code.delete(m_color)
      new_guess.delete(m_color)
    end

    count = 0
    new_code.each do |c_color|
      new_guess.each do |g_color|
        count += 1 if c_color == g_color
      end
    end
    count
  end

  def feedback(code, guess)
    match = right_pos(code, guess)
    puts "Colors in the right position: #{match.length}."
    puts "Colors in the wrong position: #{wrong_pos(code, guess, match)}."
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
    p code
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
