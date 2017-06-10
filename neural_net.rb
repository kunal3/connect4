require_relative 'matrice.rb'

class Node

end

class NeuralNet
  def initialize(args = {})
    @random = Random.new

    @activation_function = args[:activation_function] || defaults[:activation_function]
    @depth               = args[:depth]               || defaults[:depth]
    @input_size          = args[:input_size]          || defaults[:input_size]
    @layer_size          = args[:layer_size]          || defaults[:layer_size]

    # TODO: differentiate input and output weights
    @weights = Array.new(@depth) do |i|
      rows = cols = @layer_size

      rows = @input_size if i == 0
      cols = 1 if i == (@depth - 1)

      Matrice::build(rows, cols) { |_i, _j| @random.rand() }
    end
  end

  # Number
  def cost(input_matrix, output_matrix)
    scalar_multiply(output_matrix - y_hat(input_matrix)).map(&:+)
  end

  private

  def defaults
    {
      :activation_function => :sigmoid,
      :depth => 1,
      :input_size => 2,
      :layer_size => 3,
    }
  end

  # Matrix
  def y_hat(input_matrix)
    @weights.reduce(input_matrix) { |output_matrix, weight_matrix| p weight_matrix; return output_matrix * weight_matrix; }
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
end

def normalize(values)
  min = values.min
  max = values.max
  range = max - min
  values.map { |v| (v - min) / range }
end

def scale(input_matrix)
  features = input_matrix.transpose
  p features
  features.row_vectors.map { |feature_values| normalize(feature_values) }
end

n = NeuralNet.new

# hrs slept, hrs studied
x = Matrix[[3, 5], [5, 1], [10, 2]]


scaled_x = scale(x)

# test scores out of 100%
y = Matrix[[0.75], [0.82], [0.93]]

j = n.cost(scaled_x, y)

puts j

prediction_x = [8, 3]
