class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    setup_pieces
  end

  def [](y, x)
    @grid[y][x]
  end

  def []=(y, x, piece)
    @grid[y][x] = piece
  end

  def to_s
    @grid.each_with_index.map do |row, row_index|
      row.each_with_index.map do |col, col_index| 
        if col.nil?
          if (row_index.even? && col_index.even?) || (row_index.odd? && col_index.odd?)
            "   ".colorize( :red ).on_white 
          else
            "   "
          end
        else
          if (row_index.even? && col_index.even?) || (row_index.odd? && col_index.odd?) 
            " #{col} ".colorize( :red ).on_white 
          else
            " #{col} ".colorize( :red )
          end
        end
      end.join("") + "\n"
    end.join("") + "\n"
  end

  def move(start_pos, end_pos)
    piece = self[start_pos[0],start_pos[1]]
    if piece.move(end_pos)
      self[end_pos[0],end_pos[1]] = piece
      self[start_pos[0],start_pos[1]] = nil
    else
      raise StandardError, "You can't move there"
    end
  end

  def dup
    duped_board = Board.new
    duped_board.grid = Array.new(8) { Array.new(8, nil) }
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |space, space_index|
        duped_board[row_index,space_index] = space.dup unless space.nil?
        duped_board[row_index,space_index].board = duped_board unless space.nil?
      end
    end
    duped_board
  end

  def opponent_moves(color)
    opponent_moves = []
    opponent_color = color == :white ? :black : :white
    opponent_pieces = find_pieces(opponent_color)
    opponent_pieces.each do |piece|
      piece.moves.each do |move|
        opponent_moves << [piece.position, move]
      end
    end
    opponent_moves
  end

  def in_check?(color)
    opponent_moves(color).map do |move|
      move[1]
    end.any? { |position| self[position[0],position[1]].is_a?(King) }
  end

  def check_move_against_check?(start_pos, end_pos)
    duped_board = self.dup
    duped_board.move(start_pos, end_pos)
    duped_board.in_check?(self[start_pos[0],start_pos[1]].color)
  end

  def valid_moves(color)
    valid_moves = []
    find_pieces(color).map do |piece|
      piece.moves.each do |move|
        valid_moves << [piece.position, move]
      end
    end
    valid_moves.reject do |move|
      check_move_against_check?(move[0], move[1])
    end
  end

  def check_mate?(color)
    valid_moves(color).empty? && in_check?(color)
  end

  def find_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |space|
        pieces << space if !space.nil? && space.color == color
      end
    end
    pieces
  end

  def over?
    check_mate?(:white) || check_mate?(:black)
  end

  def setup_pieces
    klasses = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    klasses.each_with_index do |klass, index|
      set_piece(klass.new(board: self), [7, index], :white)
    end
    (0..7).each do |x|
      set_piece(Pawn.new(board: self), [6, x], :white)
    end

    klasses.each_with_index do |klass, index|
      set_piece(klass.new(board: self), [0, index], :black)
    end
    (0..7).each do |x|
      set_piece(Pawn.new(board: self), [1, x], :black)
    end
  end

  def set_piece(piece, pos, color)
    piece.position = pos
    piece.color = color
    self[pos[0], pos[1]] = piece
  end
end