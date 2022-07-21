
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'display.rb'  
def play
    game = Game.new
    game.play(@player1)
end


play