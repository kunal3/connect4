require_relative 'matrice.rb'

require 'pp'

class InvalidColorException < StandardError
end

class Piece
  RED = 1
  BLACK = 2
  COLORS = [RED, BLACK]

  attr_accessor :color

  def initialize(color)
    throw InvalidColorException unless COLORS.include?(color)
    @color = color
  end

  def red?
    color == RED
  end

  def black?
    color == BLACK
  end

  def to_s
    red? ? 'x' : 'o'
  end
end

# TODO: add documentation
class Board
  def initialize(matrix = nil)
    # 6 rows, 7 columns
    @matrix = matrix || Matrice.build(6, 7) { nil }
  end

  def drop_piece(col_index, color)
    piece = Piece.new(color)
    col = @matrix.column(col_index).to_a
    col[col.index(nil)] = piece
    pp col
    pp @matrix
  end

  def rows
    @matrix.rows
  end

  def cols
    @matrix.cols
  end

  def to_s
    pp rows

    return

    p_cols = rows.map do |col|
      col.map do |piece|
        piece ? piece.to_s : ' '
      end
    end

    pipe_rows = p_cols.map do |row|
      row.join('|')
    end

    pipe_rows.join("\n")
  end
end

class Game
  def initialize
    @board = Board.new
  end

  def end?; end
end

# m = Matrix.build(6, 7) { nil }
# pp m
# m[0, 6] = Piece.new(Piece::RED)
# pp m
# puts m.to_s

board = Board.new
board.drop_piece(0, Piece::RED)
board.drop_piece(3, Piece::BLACK)
board.drop_piece(3, Piece::RED)
pp board
puts board
