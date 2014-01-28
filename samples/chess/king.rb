class King < SteppingPiece

  KING_DIFFS = [[-1,1],[-1,0],[-1,-1],
          [0,-1],[0,1],
          [1,1],[1,0],[1,-1]]

  def moves
    possible_moves(KING_DIFFS)
  end

  def dup
    duped_piece = King.new(color: self.color, position: self.position.dup)
  end

end