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

  def instr_computer_guess
    puts 'Create the 4 color code typing the names of the colors separated by commas.'
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
    match
  end

  def wrong_pos(code, guess, match)
    new_code = code.map(&:clone)
    new_guess = guess.map(&:clone)
    match.each do |m_color|
      new_code.delete(m_color)
      new_guess.delete(m_color)
    end

    count = 0
    new_code.each do |c_color|
      new_guess.each { |g_color| count += 1 if c_color == g_color }
    end
    count
  end

  def feedback(code, guess)
    match = right_pos(code, guess)
    [match.length, wrong_pos(code, guess, match)]
  end

  def turns_loop(player, code)
    info = false
    until win || turn > 12
      puts '___________________________________________________________'
      puts "This is turn number #{turn} out of 12."
      guess = info ? player.guess_with_fb(info, self) : player.take_guess
      @win = compare(code, guess)
      @turn += 1
      puts 'Victory!' if win
      puts 'Defeat. No more guesses left.' if turn > 12
      info = feedback(code, guess) unless win || turn > 12
      puts "Colors in the right position: #{info[0]}."
      puts "Colors in the wrong position: #{info[1]}."
    end
  end

  def choose_role
    puts "Type 'guess' if you want to guess a computer generated code."
    puts "Type 'code' if you want to create a code and the computer will try to guess it."
    print 'Your answer: '
    gets.chomp
  end
end

class Computer
  def initialize
    @combos = []
  end

  attr_accessor :code, :guess, :combos

  def create_code(game)
    @code = game.colors.sample(4)
  end

  def take_guess
    @guess = %w[red blue green yellow pink black].sample(4)
    puts "Computer guessed: #{guess}."
    guess
  end

  def guess_combos
    %w[red blue green yellow pink black].permutation(4) { |c| @combos.push(c) }
  end

  def guess_with_fb(info, game)
    copy_combos = combos.map(&:clone)
    copy_combos.each do |combo|
      new_info = game.feedback(combo, guess)
      copy_combos.delete(combo) unless info == new_info
    end

    table = {}
    combos.each_with_index do |combo, index|
      column = []
      copy_combos.each do |copy_combo|
        grade = game.feedback(copy_combo, combo)
        column.push(grade)
      end
      table[index] = column
    end

    points = {}
    table.each do |key, grades|
      uniques = grades.uniq
      counts = {}
      uniques.each do |unique|
        count = grades.count(unique)
        counts[unique] = count
      end
      points[key] = counts
    end

    scores = {}
    points.each { |key, counts| scores[key] = counts.values.max }

    min_val = scores.values.min
    guess_index = scores.key(min_val)

    new_guess = combos[guess_index]
    puts "Computer guessed: #{new_guess}."
    new_guess
  end
end

class Player
  def initialize; end

  attr_accessor :code, :guess

  def take_guess
    print 'Type your guess (Each color separated by a comma): '
    @guess = gets.chomp.gsub!(' ', '').split(',')
  end

  def guess_with_fb(*)
    take_guess
  end

  def create_code
    print 'Your code: '
    @code = gets.chomp.gsub!(' ', '').split(',')
  end
end

def player_guesses(game, computer, player)
  game.instr_player_guess
  code = computer.create_code(game)
  game.turns_loop(player, code)
end

def computer_guesses(game, computer, player)
  computer.guess_combos
  game.instr_computer_guess
  code = player.create_code
  game.turns_loop(computer, code)
end

def game_mode(role, game, computer, player)
  player_guesses(game, computer, player) if role == 'guess'
  computer_guesses(game, computer, player) if role == 'code'
end

game = Game.new
computer = Computer.new
player = Player.new
game.welcome
role = game.choose_role
game_mode(role, game, computer, player)
