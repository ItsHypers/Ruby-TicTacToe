class Board
    attr_reader :cells
  
    WINNING_COMBOS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ].freeze
  
    def initialize
      @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
    public
    def show
        puts ""
        puts "#{cells[0]} ┃ #{cells[1]} ┃ #{cells[2]}"
        puts"━━✢━━━✢━━"
        puts"#{cells[3]} ┃ #{cells[4]} ┃ #{cells[5]}"
        puts"━━✢━━━✢━━"
        puts"#{cells[6]} ┃ #{cells[7]} ┃ #{cells[8]}"
        puts ""
    end
    public
    def update_board(number, symbol)
      @cells[number] = symbol
    end
    public
    def valid_move?(number)
        cells[number - 1] == number
      end
      public
    def game_over?
      WINNING_COMBOS.any? do |combo|
        [cells[combo[0]], cells[combo[1]], cells[combo[2]]].uniq.length == 1
      end
    end
  end