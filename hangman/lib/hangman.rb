# Create class player
# Create class game
# Game welcomes the player and explains the rules
# Game loads in the dictionary
# Game randomly selects a word between 5 and 12 char
# Game-loop starts
# Player selects a letter
# Game checks if letter is in word
# If letter is in word, game displays it in the right spot
# If letter is not in word, game displays it in the list of checked letters
# If all the letters of the word are displayed, game ends and player wins
# If letter is not in word, game substracts one from chances to guess
# Game checks number of chances
# If chances is zero, game ends and player looses
# Game-loop ends

require 'json'

class Game
  def initialize
    @chances = 6
    @words = []
    @wrong_letters = []
    @end = false
  end

  attr_reader :end, :word

  SAVEFILE = 'saved_game/saved.json'.freeze

  def explain_rules
    puts '|=======================|'
    puts '|==Welcome to Hangman!==|'
    puts '|=======================|'
    puts ' '
    puts 'Pick a letter to see if it appears in the random word. You have 6 chances to guess.'
  end

  def load_dic
    File.foreach('words_dict.txt') do |word|
      word.chomp!
      @words.push(word) if word.length.between?(5, 12)
    end
  end

  def assing_saved_attr
    game_attr = JSON.parse(File.read(SAVEFILE))

    @word = game_attr['word']
    @chances = game_attr['chances']
    @wrong_letters = game_attr['wrong_letter'] if game_attr['wrong_letter']
    @spaces = game_attr['spaces']

    display_spaces
  end

  def ask_to_play_saved
    return unless File.exist?(SAVEFILE)

    print "There's a saved game. Would you like to continue it? y/n: "
    answer = gets.chomp.downcase
    return unless %w[y yes].include?(answer)

    assing_saved_attr
  end

  def choose_word
    @word = @words.sample
  end

  def display_spaces
    puts @spaces.join
  end

  def create_spaces
    @spaces = []
    @word.length.times { @spaces.push('_ ') }
    display_spaces
  end

  def update_spaces(letter, index)
    @spaces[index] = letter
  end

  def update_wrongs(letter)
    @wrong_letters.push(letter)
    @chances -= 1
    puts '~~~~~~~~~~~~~~'
    print 'Wrong letters: '
    @wrong_letters.each { |char| print "#{char} " }
    puts ' '
    puts "Chances left: #{@chances}."
  end

  def check_letter(letter)
    arr_word = @word.split('')
    if arr_word.include?(letter)
      arr_word.each_with_index do |char, index|
        update_spaces(letter, index) if char == letter
      end
    else
      update_wrongs(letter)
    end
    display_spaces
  end

  def check_win
    return unless @spaces.join == @word

    puts ' '
    puts 'Congratulations! You win!'
    @end = true
  end

  def check_lose
    return unless @chances.zero?

    puts ' '
    puts "You're out of chances! You lose!"
    @end = true
  end

  def check_end
    check_win
    check_lose
    return unless @end

    File.delete(SAVEFILE) if File.exist?(SAVEFILE)
  end

  def saved_end
    puts ' '
    puts 'Game saved, see you next time!'
    @end = true
  end

  def save_game
    Dir.mkdir('saved_game') unless Dir.exist?('saved_game')

    hash = { word: @word, chances: @chances, wrong_letters: @wrong_letters, spaces: @spaces }

    File.open(SAVEFILE, 'w') { |file| File.write(file, JSON.generate(hash)) }
    saved_end
  end

  def ask_to_save
    return if @end

    print 'Would you like to save the game? y/n: '
    answer = gets.chomp.downcase
    save_game if %w[y yes].include?(answer)
  end
end

class Player
  def initialize; end

  attr_reader :letter

  def choose_letter
    puts ' '
    print 'Choose a letter: '
    @letter = gets.chomp.downcase
  end
end

game = Game.new
player = Player.new
game.explain_rules
game.load_dic
game.ask_to_play_saved

unless game.word
  game.choose_word
  game.create_spaces
end

until game.end
  letter = player.choose_letter
  game.check_letter(letter)
  game.check_end
  game.ask_to_save
end
