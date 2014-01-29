class Pawn < Piece
  def dup
    duped_piece = Pawn.new(color: self.color, position: self.position.dup)
  end

  def moves
    moves = []
    set_diffs.each do |diff|
      y, x = @position
      dy, dx = diff
      moves << [y + dy, x + dx] if pos_in_bounds?([y + dy, x + dx])
    end
    moves
  end


  def set_diffs
    diag_diffs = []
    y, x = @position
    [[attack_vector, -1],[attack_vector, 1]].each do |diff|
      checked_square = @board.grid[diff[0] + y][diff[1] + x]
      if !checked_square.nil? && checked_square.color != @color
        diag_diffs << diff
      end
    end
    diag_diffs + forward_diffs
  end

  def forward_diffs
    attack_vector == 1 ? pawn_row = 1 : pawn_row = 6
    y, x = @position
    # => Checking one move forward
    forward_diffs = []
    pos1 = [y + attack_vector, x]
    if pos_available?(pos1) && pos_in_bounds?(pos1)
      forward_diffs << [attack_vector,0]
      if y == pawn_row
        pos2 = [y + attack_vector*2, x]
        forward_diffs << [attack_vector*2,0] if pos_available?(pos2)
      end
    end
    forward_diffs
  end

  def attack_vector
    @color == :white ? -1 :  1
  end

  def pos_available?(pos)
    # @board[pos[0], pos[1]]
    square = @board[pos[0],pos[1]]
    square.nil?
  end
end