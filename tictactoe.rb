# This is the second idea

class Player
  def initialize(name)
    @name = name
  end

  attr_reader :name

  def choose_number(_game)
    print "#{@name}, select a number to place your symbol: "
    gets.chomp.to_s
  end
end

class Game
  def initialize
    @board = %w[1|2|3 4|5|6 7|8|9]
    @win = false
    @symbols = %w[X O]
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
      puts @board
    end
  end

  def check_win
    @win = hor_win

    @win ||= ver_win

    puts 'Someone won!' if @win
    @win
  end

  def hor_win
    combos = %w[X|X|X O|O|O]
    combos.each do |combo|
      @win = @board.include?(combo)
      break if @win
    end
    @win
  end

  def ver_combos(level, symbol, cols)
    if level[0] == symbol
      symbol == 'X' ? cols[:colx1] += 1 : cols[:colo1] += 1
    end
    if level[2] == symbol
      symbol == 'X' ? cols[:colx2] += 1 : cols[:colo2] += 1
    end
    if level[4] == symbol
      symbol == 'X' ? cols[:colx3] += 1 : cols[:colo3] += 1
    end
    cols
  end

  def ver_win
    cols = { colx1: 0, colx2: 0, colx3: 0, colo1: 0, colo2: 0, colo3: 0 }
    new_cols = {}
    @board.each do |level|
      @symbols.each do |symbol|
        new_cols = ver_combos(level, symbol, cols)
      end
    end
    @win = new_cols.value?(3)
    @win
  end

  def round_loop(player1, player2)
    players = [player1, player2]
    until @win
      players.each do |player|
        @win = check_win
        break if @win

        edit_board(player)
        puts ' '
      end
    end
  end
end

game = Game.new
players = game.ask_names
player1 = Player.new(players[0])
player2 = Player.new(players[1])
puts "Welcome #{player1.name} and #{player2.name}. Let's play!"
puts game.board
game.round_loop(player1, player2)
