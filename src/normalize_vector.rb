require 'pp'

def normalize_vector(values)
  pp '[normalize] values', values
  min = values.min
  pp '[normalize] min', min
  max = values.max
  pp '[normalize] max', max
  range = max - min
  pp '[normalize] range', range
  return values if range.zero?
  normalized_values = values.map { |v| (v - min).fdiv(range) }
  pp '[normalize] normalized_values', normalized_values
  normalized_values
end
