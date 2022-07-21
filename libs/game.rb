require_relative 'display.rb'
require_relative 'board.rb'
class Game
    include Display
    attr_reader :player1, :player2, :board, :current_player, :moves
    def initialize
        @board = Board.new
        @player1 = nil
        @player2 = nil
        @current_player = nil
        @moves = 1
    end
    public
    def play(player1)
        start_game
        if(@player1 == nil)
            create_players
        else
            @board = Board.new
            @moves = 1
        end
        game_loop
        replay_game
    end
    private
    def game_loop
        while @moves <= 9
            puts "#{current_player.name} pick a number 1-9"
            number = gets.chomp.to_i
            if @board.valid_move?(number)
                @board.update_board(number - 1, current_player.symbol)
                @board.show
                if(@board.game_over?)
                    winner_announce(current_player)
                    replay_game
                end
                @current_player = change_current_player
                @moves += 1
            else
                puts "Not a valid move!"
            end
        end
        draw
        return
    end
    private
    def create_players
        @player1 = create_player(1)
        @player2 = create_player(2)
        @current_player = @player1
    end
    private
    def create_player(number)
        puts "What is your name, Player #{number}"
        @name = gets.chomp
        puts "What Symbol would you like to use?"
        @symbol = gets.chomp
        if number == 2
            duplicateCheck(@name, @symbol)
        end
        Player.new(number, name, symbol)
    end
    private
    def duplicateCheck(name, symbol)
        if name == @player1.name
            puts "You can not use the same name!"
            @player2 = create_player(2)
        end

        if symbol == @player1.symbol
            puts "You can not use the same symbol!"
            @player2 = create_player(2)
        end
        return
    end
    private
    def change_current_player
        current_player == @player1 ? @player2 : @player1
    end
    private
    def replay_game
        puts "Would you like to replay? (Y/N)"
        input = gets.chomp
        if input == "Y"
            play(@player1)
        else
            puts "Thank you for playing"
            return
        end
    end
end