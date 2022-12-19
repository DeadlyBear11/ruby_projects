class Player
  def initialize(name)
    @name = name
  end

  attr_reader :name
end

class Game
  def initialize(players)
    @players = players
  end

  attr_reader :players
end

def set_players_names
  players = [1, 2]
  players.each_index do |index|
    print "Type player #{index + 1}'s name: "
    players[index] = Player.new(gets.chomp)
    puts "Player #{index + 1} is #{players[index].name}."
  end
  puts "\nLet's start the game!\n"
  players
end

def update_board(board, selection, game, player)
  s = selection.to_s
  board.each_with_index do |level, index|
    arr = level.chars
    next unless arr.include?(s)

    player == game.players[0].name ? arr.fill('X', arr.find_index(s), 1) : arr.fill('O', arr.find_index(s), 1)

    board[index] = arr.join('')
  end
  board
end

def play_turn(game, board)
  game.players.each do |player|
    puts "It's #{player.name}'s turn."
    puts board
    print "\nSelect a number to place your symbol: "
    selection = gets.chomp
    update_board(board, selection, game, player.name)
  end
  board
end

def play_game(game, board)
  while true
    play_turn(game, board)
  end
end

# Create new game and two players.
game = Game.new(set_players_names)

# Create the board.
board = ['1|2|3', '4|5|6', '7|8|9']

play_game(game, board)
# Check for a win.
# If there's a win:
# display board with past selections on it.
# display what player won.
# allow players to play again or to end program.
# Else:
# Display board with past selections on it.
# Allow player 1 to select a box on the board.
# Safe the selection.
# Display board with past selections on it.
# Allow player 2 to select a box on the board.
