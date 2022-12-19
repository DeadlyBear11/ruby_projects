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
  puts ' '
  puts "Let's start the game!"
  puts ' '
  players
end

# Create new game and two players.
game = Game.new(set_players_names)

# Create the board.
board = ['1|2|3', '4|5|6', '7|8|9']

# Game Loop
game.players.each do |player|
  puts "It's #{player.name}'s turn."
  puts board
  puts ' '
  print 'Select a number to place your symbol: '
  selection = gets.chomp
  puts "Your selection was: #{selection}."
end

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
