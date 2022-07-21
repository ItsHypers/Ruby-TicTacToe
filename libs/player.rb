class Player
    attr_reader :number, :name, :symbol
    def initialize(number, name, symbol)
        @number = number
        @name = name
        @symbol = symbol
    end
end