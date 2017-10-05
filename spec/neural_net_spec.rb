require_relative 'spec_helper'
require_relative '../src/neural_net'

RSpec.describe 'neural_net' do
  describe '#cost' do
    it 'returns the cost difference between the input and expected output' do
      weights = [
        Matrix[
          [0.7898270473647127, 0.052130123671403794, 0.7595361755334088],
          [0.006720706632005746, 0.10409120418790119, 0.6729014981669036],
        ],
        Matrix[
          [0.3009559673833263], [0.18930485891991788], [0.588706962790872],
        ],
      ]
      neural_net = NeuralNet.new(input_dimension: 2, weights: weights)
      scaled_input = Matrix[[0.0, 1.0], [0.2857142857142857, 0.0], [1.0, 0.25]]
      expected_output = Matrix[[0.75], [0.82], [0.93]]
      expected_cost = 0.18787265063160385
      cost = neural_net.cost(scaled_input, expected_output)
      expect(cost).to eq(expected_cost)
    end
  end
end
