# encoding: utf-8

class Piece
  SYMBOLS = {
    :white => {
      "King" => "♔",
      "Queen" => "♕",
      "Knight" => "♘",
      "Rook" => "♖",
      "Bishop" => "♗",
      "Pawn" => "♙"
    },
    :black => {
      "King" => "♚",
      "Queen" => "♛",
      "Knight" => "♞",
      "Rook" => "♜",
      "Bishop" => "♝",
      "Pawn" => "♟"
    }
  }

  attr_accessor :position, :color, :board

  def initialize(options)
    @position = options[:position]
    @color = options[:color]
    @board = options[:board]
  end



  def moves
    raise NotImplementError.new("move has not been implemented for this piece")
    # raise NotImplementedError, "asdf"
  end

  def move(end_pos)
    if moves.include?(end_pos)
      @position = end_pos
      true
    end
  end

  def pos_in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def pos_available?(pos)
    # @board[pos[0], pos[1]]
    square = @board.grid[pos[0]][pos[1]]
    square.nil? || square.color != @color
  end

  def to_s
    SYMBOLS[@color][self.class.to_s]
  end

end



