class Queen < SlidingPiece

  def move_dirs
    possible_moves(ORTHOGONALS) + possible_moves(DIAGONALS)
  end

  def dup
    duped_piece = Queen.new(color: self.color, position: self.position.dup)
  end

end