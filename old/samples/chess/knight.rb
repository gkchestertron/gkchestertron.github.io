class Knight < SteppingPiece
  KNIGHT_DIFFS = [[1, 2],
                 [1, -2],
                 [2, 1],
                 [2, -1],
                 [-1, 2],
                 [-1, -2],
                 [-2, 1],
                 [-2, -1]]

  def moves
    possible_moves(KNIGHT_DIFFS)
  end

  def dup
    duped_piece = Knight.new(color: self.color, position: self.position.dup)
  end
end