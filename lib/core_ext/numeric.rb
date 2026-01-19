# frozen_string_literal: true

# Extending core class Numeric
class Numeric
  def whole?
    (self % 1).zero?
  end

  def multiple_of?(other)
    return zero? && other.zero? if zero? || other.zero?

    (to_f / other).whole?
  end
end
