# A 'vector' is an Array of Numbers.

require_relative 'normalize_vector'

def scale_feature_vector_matrix(input_matrix)
  features = input_matrix.transpose
  row_vectors = features.row_vectors
  normalized_vectors = row_vectors.map { |vector| normalize_vector(vector) }
  # TODO: should un-transpose?
  return Matrix[[]] if row_vectors.length.zero?
  Matrix::build(row_vectors.length, row_vectors[0].size) do |row, col|
    normalized_vectors[row][col]
  end.transpose
end
