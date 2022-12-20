# This is the second idea

class Player
  def initialize(name)
    @name = name
  end

  attr_reader :name

  def choose_number(game)
    puts game.board
    print "#{@name}, select a number to place your symbol: "
    gets.chomp.to_s
  end
end

class Game
  def initialize
    @board = %w[1|2|3 4|5|6 7|8|9]
    @win = false
  end

  attr_accessor :board, :win

  def ask_names
    @players = []
    2.times do
      print "Typle player's name: "
      @players.push(gets.chomp)
    end
    @players
  end

  def edit_board(player)
    number = player.choose_number(self)
    @board.each_with_index do |level, index|
      arr = level.chars
      next unless arr.include?(number)

      if player.name == @players[0]
        arr.fill('X', arr.find_index(number), 1)
      else
        arr.fill('O', arr.find_index(number), 1)
      end

      @board[index] = arr.join('')
    end
  end
end

game = Game.new
players = game.ask_names
player1 = Player.new(players[0])
player2 = Player.new(players[1])
puts "Welcome #{player1.name} and #{player2.name}. Let's play!"
game.edit_board(player1)
puts game.board
