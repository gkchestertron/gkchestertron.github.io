require_relative 'chess'

class Game
  def initialize
    @board = Board.new
    @turn = :white
  end

  def play
    print @board.to_s
    until @board.over?
      take_turn
    end
    puts "CHECKMATE!"
  end

  def take_turn
    begin
      if @board.in_check?(@turn)
        puts "You are in check!"
      end
      puts "#{@turn.to_s}, it's your turn"
      puts "Please select a piece"
      start_pos = gets.chomp
      start_pos = start_pos.split(",").map(&:to_i)
      unless @board[start_pos[0],start_pos[1]].color == @turn
        puts "It's not your turn!!!!"
        return
      end
      puts "Where are you going?"
      end_pos = gets.chomp
      end_pos = end_pos.split(",").map(&:to_i)
      if @board.check_move_against_check?(start_pos, end_pos)
        raise "You can't move into check"
      else
        @board.move(start_pos,end_pos)
      end
    rescue => e
      puts e.message
      retry
    end
    print @board.to_s
    @turn = @turn == :white ? :black : :white
  end
end

g = Game.new
g.play