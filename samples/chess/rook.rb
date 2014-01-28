class Rook < SlidingPiece

  # def initialize(options = {})
  #   super
  # end

  def move_dirs
    possible_moves(ORTHOGONALS)
  end

  def dup
    duped_piece = Rook.new(color: self.color, position: self.position.dup)
  end


end