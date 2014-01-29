class Bishop < SlidingPiece
  def move_dirs
    possible_moves(DIAGONALS)
  end

  def dup
    duped_piece = Bishop.new(color: self.color, position: self.position.dup)
  end
end