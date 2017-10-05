require 'matrix'

require 'pp'
require 'pry'

require_relative 'scale_feature_vector_matrix'

class NeuralNet
  def initialize(args = {})
    # TODO: validate input_dimension against weights
    set_defaults!(args)
    @input_dimension = args[:input_dimension]
    pp '[NeuralNet.new] @input_dimension', @input_dimension
    @weights = args[:weights] || initial_weights(:random_initial_weight)
    pp '[NeuralNet.new] @weights', @weights
    self
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

  def set_defaults!(args)
    @activation_function = args[:activation_function] || defaults[:activation_function]
    @depth               = args[:depth]               || defaults[:depth]
    @layer_size          = args[:layer_size]          || defaults[:layer_size]

    pp '[NeuralNet.new] @activation_function', @activation_function
    pp '[NeuralNet.new] @depth', @depth
    pp '[NeuralNet.new] @layer_size', @layer_size

    self
  end

  def defaults
    {
      :activation_function => :sigmoid,
      :depth => 1,
      :layer_size => 3,
    }
  end

  def initial_weights(strategy)
    # TODO: differentiate input and output weights
    # TODO: create helpers to iterate through layers

    num_weights = @depth + 1

    pp '[NeuralNet.new] num_weights', num_weights

    Array.new(num_weights) do |n|
      pp '[Array.new(@depth)] n', n
      rows = cols = @layer_size

      rows = @input_dimension if n == 0
      cols = 1                if n == (num_weights - 1)

      pp '[Array.new(@depth)] rows', rows
      pp '[Array.new(@depth)] cols', cols

      Matrix::build(rows, cols) do |row_index, col_index|
        self.send(strategy, row_index, col_index)
      end
    end
  end

  def random_initial_weight(_row, _col)
    random.rand
  end

  def random
    @random ||= Random.new
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

neural_net = NeuralNet.new(input_dimension: 2)

pp 'neural_net', neural_net

# hrs slept, hrs studied
x = Matrix[[3, 5], [5, 1], [10, 2]]

pp 'x', x

scaled_x = scale_feature_vector_matrix(x)

pp 'scaled_x', scaled_x

# test scores out of 100%
y = Matrix[[0.75], [0.82], [0.93]]
y_hat = neural_net.y_hat(scaled_x)

pp 'y', y
pp 'y_hat', y_hat

j = neural_net.cost(scaled_x, y)

pp 'j', j

# TODO: minimize cost function

# TODO: make predictions

prediction_x = [8, 3]
