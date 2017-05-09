# Column oriented. i.e. matrix[col][row] ~> value
class Matrix
  attr_accessor :cols

  def initialize(cols, rows)
    @row_size = cols
    @column_size = rows

    @cols = Array.new(@column_size) { Array.new(@row_size) }
  end

  def [](i)
    @cols[i]
  end
end

class InvalidColorException < StandardError
end

class Piece
  RED = 1
  BLACK = 2
  COLORS = [RED, BLACK]

  attr_accessor :color

  def initialize(color)
    throw InvalidColorException if !COLORS.include?(color)
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

class Board
  # Piece - knows its own color
  # Board could be 0, 1, 2 - empty, red, black
  # Piece could know color and pos

  def initialize(matrix=nil)
    @matrix = matrix || Matrix.new(cols=7, rows=6)
  end

  def drop_piece(col, color)
    piece = Piece.new(color)
    col = @matrix[col]
    col[col.index(nil)] = piece
  end

  def rows
    @matrix.rows
  end

  def cols
    @matrix.cols
  end

  def to_s
    p_cols = cols.map do |col|
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

board = Board.new
board.drop_piece(0, Piece::RED)
board.drop_piece(3, Piece::BLACK)
board.drop_piece(3, Piece::RED)
p board
puts board
