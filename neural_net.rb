require_relative 'matrice.rb'

require 'pp'
require 'pry'

class NeuralNet
  def initialize(args = {})
    @random = Random.new

    @activation_function = args[:activation_function] || defaults[:activation_function]
    @depth               = args[:depth]               || defaults[:depth]
    @input_dimension     = args[:input_dimension]     || defaults[:input_dimension]
    @layer_size          = args[:layer_size]          || defaults[:layer_size]

    pp '[NeuralNet.new] @activation_function', @activation_function
    pp '[NeuralNet.new] @depth', @depth
    pp '[NeuralNet.new] @input_dimension', @input_dimension
    pp '[NeuralNet.new] @layer_size', @layer_size

    # TODO: differentiate input and output weights

    num_weights = @depth + 1

    pp '[NeuralNet.new] num_weights', num_weights

    @weights = Array.new(num_weights) do |i|
      pp '[Array.new(@depth)] i', i
      rows = cols = @layer_size

      rows = @input_dimension if i == 0
      cols = 1                if i == (num_weights - 1)

      pp '[Array.new(@depth)] rows', rows
      pp '[Array.new(@depth)] cols', cols

      Matrix::build(rows, cols) { |_i, _j| @random.rand() }
    end

    pp '[NeuralNet.new] @weights', @weights
  end

  # Number
  def cost(input_matrix, output_matrix)
    pp '[cost] input_matrix', input_matrix
    pp '[cost] output_matrix', output_matrix
    # TODO: reduce?
    y_hat = y_hat(input_matrix)
    pp '[cost] y_hat', y_hat
    error_matrix = output_matrix - y_hat
    pp '[cost] error_matrix', error_matrix
    error_squared_matrix = scalar_exponentiate(error_matrix, 2)
    pp '[cost] error_squared_matrix', error_squared_matrix
    variance_matrix = scalar_multiply(0.5, error_squared_matrix)
    pp '[cost] variance_matrix', variance_matrix
    variance_matrix.each.reduce(:+)
  end

  # Matrix
  def y_hat(input_matrix)
    @weights.reduce(input_matrix) do |output_matrix, weight_matrix|
      pp '[y_hat] output_matrix', output_matrix
      pp '[y_hat] weight_matrix', weight_matrix
      activate_matrix(output_matrix * weight_matrix)
    end
  end

  private

  def defaults
    {
      :activation_function => :sigmoid,
      :depth => 1,
      :layer_size => 3,
    }
  end

  # Number
  def activate_matrix(matrix)
    matrix.map { |value| activate(value) }
  end

  def activate(number)
    send(@activation_function, number)
  end

  def sigmoid(power)
    1 / (Math::E ** power)
  end

  def scalar_multiply(number, matrix)
    matrix.map { |v| v * number }
  end

  def scalar_exponentiate(matrix, power)
    matrix.map { |v| v ** power }
  end

  def matrix_reduce(matrix, &block)
    # M-F*CKING HAMMER TIME
    #
  end
end

def normalize(values)
  pp '[normalize] values', values
  min = values.min
  pp '[normalize] min', min
  max = values.max
  pp '[normalize] max', max
  range = max - min
  pp '[normalize] range', range
  normalized_values = values.map { |v| (v - min).fdiv(range) }
  pp '[normalize] normalized_values', normalized_values
  normalized_values
end

def scale(input_matrix)
  features = input_matrix.transpose
  pp '[scale] features', features
  row_vectors = features.row_vectors
  pp '[scale] row_vectors', row_vectors
  normalized_vectors = row_vectors.map { |feature_values| normalize(feature_values) }
  # TODO: should un-transpose?
  pp '[scale] normalized_vectors', normalized_vectors
  Matrix::build(row_vectors.length, row_vectors[0].size) { |row, col| normalized_vectors[row][col] }.transpose
  # normalized_vectors
end

neural_net = NeuralNet.new(input_dimension: 2)

pp 'neural_net', neural_net

# hrs slept, hrs studied
x = Matrix[[3, 5], [5, 1], [10, 2]]

pp 'x', x

scaled_x = scale(x)

pp 'scaled_x', scaled_x

# test scores out of 100%
y = Matrix[[0.75], [0.82], [0.93]]
y_hat = neural_net.y_hat(scaled_x)

pp 'y', y
pp 'y_hat', y_hat

j = neural_net.cost(scaled_x, y)

pp j

# TODO: minimize cost function

# TODO: make predictions

prediction_x = [8, 3]
