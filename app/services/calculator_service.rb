# frozen_string_literal: true
module Services
  class CalculatorService
    def self.add(a, b)
      validate_numeric!(a, b)
      a + b
    end

    def self.subtract(a, b)
      validate_numeric!(a, b)
      a - b
    end

    def self.multiply(a, b)
      validate_numeric!(a, b)
      a * b
    end

    def self.divide(a, b)
      validate_numeric!(a, b)
      raise ZeroDivisionError if b.zero?

      a.to_f / b
    end

    def self.exponentiate(base, exponent)
      validate_numeric!(base, exponent)
      base ** exponent
    end

    private

    def self.validate_numeric!(*args)
      args.each do |arg|
        raise ArgumentError, "Expected Numeric, got #{arg.class}" unless arg.is_a?(Numeric)
      end
    end
  end
end
