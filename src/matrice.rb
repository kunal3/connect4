require 'matrix'

# Custom class Matrice extends ruby class Matrix
# Row-oriented
class Matrice < Matrix
  attr_accessor :rows

  def []=(i, j, value)
    @rows[i][j] = value
  end

  def [](i)
    @rows[i]
  end
end

# class Matrix
#   def []=(i, j, value)
#     @rows[i][j] = value
#   end
# end

# # Column oriented. i.e. matrix[col][row] ~> value
# class Matrix
#   attr_accessor :cols

#   def initialize(cols, rows)
#     @row_size = cols
#     @column_size = rows

#     @cols = Array.new(@column_size) { Array.new(@row_size) }
#   end

#   def [](i)
#     @cols[i]
#   end

#   def rows
#     return @cols.transpose
#     response = []
#     @cols.each do |col|
#       col.each_with_index do |value, index|
#         response[index] << value
#       end
#     end
#     response
#   end
# end
