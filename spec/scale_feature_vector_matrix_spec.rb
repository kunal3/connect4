require 'matrix'

require_relative 'spec_helper'
require_relative '../scale_feature_vector_matrix'

RSpec.describe 'scale_feature_vector_matrix' do
  it 'scales each value in the matrix' do
    x = Matrix[[3, 5], [5, 1], [10, 2]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[0.0, 1.0], [0.2857142857142857, 0.0], [1.0, 0.25]]
    expect(result).to eq(expected)
  end

  it 'works on empty Matrix' do
    x = Matrix[[]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[]]
    expect(result).to eq(expected)
  end

  it 'works on 1x1 Matrix' do
    x = Matrix[[5]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[5]]
    expect(result).to eq(expected)
  end

  it 'works on 1x2 Matrix' do
    x = Matrix[[5, 3]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[5, 3]]
    expect(result).to eq(expected)
  end

  it 'works on 2x1 Matrix' do
    x = Matrix[[5], [3]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[1.0], [0.0]]
    expect(result).to eq(expected)
  end

  it 'works on 3x1 Matrix' do
    x = Matrix[[5], [3], [10]]
    result = scale_feature_vector_matrix(x)
    expected = Matrix[[0.2857142857142857], [0.0], [1.0]]
    expect(result).to eq(expected)
  end
end
