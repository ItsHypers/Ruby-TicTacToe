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
            @board.show
            puts "#{current_player.name} pick a number 1-9"
            number = gets.chomp.to_i
            if @board.valid_move?(number)
                @board.update_board(number - 1, current_player.symbol)
                @board.show
                if(@board.game_over?)
                    winner_announce(current_player)
                    return
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
        player_name(number)
    end
    private
    def player_name(number)
        puts "What is your name, Player #{number}"
        @name = gets.chomp
        if !name_dupe_check(@name, number)
            player_symbol(@name, number)
        end
    end
    private
    def player_symbol(name, number)
        puts "What Symbol would you like to use?"
        @symbol = gets.chomp
        if !symbol_dupe_check(name, number, @symbol)
            player_create(number, @name, @symbol)
        end
    end

    private
    def name_dupe_check(name, number)
        if(@player1 != nil)
            if name == @player1.name
                puts "You can not use the same name!"
                player_name(number)
                return true
            else
                return false
            end
        end
        return false
    end

    def symbol_dupe_check(name, number, symbol)
        if(@player1 != nil)
            if symbol == @player1.symbol
                puts "You can not use the same symbol!"
                player_symbol(name, number)
                return true
            end
        end
        if symbol.length != 1
            puts "Symbols can only be 1 character long!"
            player_symbol(name, number)
            return true
        end
        return false
    end
    private
    def player_create(number, name, symbol)
        Player.new(number, name, symbol)
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
        end
    end
end