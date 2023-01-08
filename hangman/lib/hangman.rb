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

class Game
  def initialize
    @chances = 6
    @words = []
    @wrong_letters = []
  end

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

  def choose_word
    @word = @words.sample
    p @word
  end

  def create_spaces
    @spaces = []
    @word.length.times { @spaces.push('_ ') }
    puts @spaces.join
  end

  def update_spaces(letter, index)
    @spaces[index] = letter
  end

  def update_wrongs(letter)
    @wrong_letters.push(letter)
    @chances -= 1
    print 'Wrong letters: '
    @wrong_letters.each { |char| print "#{char} " }
    puts "Chances left: #{@chances}."
  end

  def check_letter(letter)
    arr_word = @word.split('')
    if arr_word.include?(letter)
      arr_word.each_with_index do |char, index|
        update_spaces(letter, index) if char == letter
      end
      puts @spaces.join
    else
      update_wrongs(letter)
    end
  end
end

class Player
  def initialize; end

  attr_reader :letter

  def choose_letter
    print 'Choose a letter: '
    @letter = gets.chomp.downcase
  end
end

game = Game.new
player = Player.new
game.explain_rules
game.load_dic
game.choose_word
game.create_spaces
letter = player.choose_letter
game.check_letter(letter)
