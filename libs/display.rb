require_relative 'player.rb'
module Display
    attr_reader :name, :symbol
    def start_game
        puts "Welcome to Hyper's TicTacToe!"
    end
    def winner_announce(current_player)
        puts "Congratulations #{current_player.name}"
    end 
    def draw
        puts "You drew!"
    end
end