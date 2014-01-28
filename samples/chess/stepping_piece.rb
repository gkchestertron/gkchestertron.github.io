class SteppingPiece < Piece

  def possible_moves(deltas)
    possible_moves = []
    deltas.each do |delta|
      y, x = @position
      dx, dy = delta
      possible_move = [y + dy, x + dx]
      if pos_in_bounds?(possible_move) && pos_available?(possible_move)
        possible_moves << possible_move
      end
    end
    possible_moves
  end

end