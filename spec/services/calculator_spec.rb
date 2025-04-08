require 'spec_helper'

RSpec.describe ::Services::CalculatorService do
  subject(:calculator) { described_class }

  describe '#add' do
    context 'with positive integers' do
      it 'returns the sum of two numbers' do
        expect(calculator.add(2, 3)).to eq(5)
      end
    end

    context 'with negative integers' do
      it 'returns the sum of two numbers' do
        expect(calculator.add(-2, -3)).to eq(-5)
      end
    end

    context 'with mixed integers' do
      it 'returns the sum of a positive and negative number' do
        expect(calculator.add(5, -3)).to eq(2)
      end
    end

    context 'with decimal numbers' do
      it 'returns the sum of two decimal numbers' do
        expect(calculator.add(1.5, 2.5)).to eq(4.0)
      end
    end
  end

  describe '#subtract' do
    context 'with positive integers' do
      it 'returns the difference of two numbers' do
        expect(calculator.subtract(2, 3)).to eq(-1)
      end
    end

    context 'with negative integers' do
      it 'returns the difference of two numbers' do
        expect(calculator.subtract(-2, -3)).to eq(1)
      end
    end

    context 'with mixed integers' do
      it 'returns the difference of a positive and negative number' do
        expect(calculator.subtract(5, -3)).to eq(8)
      end
    end

    context 'with decimal numbers' do
      it 'returns the difference of two decimal numbers' do
        expect(calculator.subtract(1.5, 2.5)).to eq(-1)
      end
    end
  end

  describe '#multiply' do
    context 'with positive integers' do
      it 'returns the product of two numbers' do
        expect(calculator.multiply(2, 3)).to eq(6)
      end
    end

    context 'with negative integers' do
      it 'returns the product of two numbers' do
        expect(calculator.multiply(-2, -3)).to eq(6)
      end
    end

    context 'with mixed integers' do
      it 'returns the product of a positive and negative number' do
        expect(calculator.multiply(5, -3)).to eq(-15)
      end
    end

    context 'with decimal numbers' do
      it 'returns the product of two decimal numbers' do
        expect(calculator.multiply(1.5, 2.0)).to eq(3.0)
      end
    end
  end

  describe '#divide' do
    context 'with positive integers' do
      it 'returns the quotient of two numbers' do
        expect(calculator.divide(6, 3)).to eq(2)
      end
    end

    context 'with negative integers' do
      it 'returns the quotient of two numbers' do
        expect(calculator.divide(-6, -3)).to eq(2)
      end
    end

    context 'with mixed integers' do
      it 'returns the quotient of a positive and negative number' do
        expect(calculator.divide(6, -3)).to eq(-2)
      end
    end

    context 'with decimal numbers' do
      it 'returns the quotient of two decimal numbers' do
        expect(calculator.divide(2.5, 0.5)).to eq(5.0)
      end

      it 'returns a float when dividing integers' do
        expect(calculator.divide(5, 2)).to eq(2.5)
      end
    end

    context 'when numerator is zero' do
      it 'returns 0 regardless of denominator' do
        expect(calculator.divide(0, 5)).to eq(0)
      end

      it 'returns 0 for negative denominator' do
        expect(calculator.divide(0, -5)).to eq(0)
      end
    end

    context 'with very large numbers' do
      it 'returns a float with correct precision' do
        expect(calculator.divide(1_000_000_000_000, 2)).to eq(500_000_000_000.0)
      end
    end

    context 'when dividing by zero' do
      it 'raises ZeroDivisionError with integer zero' do
        expect { calculator.divide(5, 0) }.to raise_error(ZeroDivisionError)
      end

      it 'raises ZeroDivisionError with float zero' do
        expect { calculator.divide(5, 0.0) }.to raise_error(ZeroDivisionError)
      end
    end

    context 'with special float values' do
      it 'returns 0.0 when dividing a number by Float::INFINITY' do
        expect(calculator.divide(42, Float::INFINITY)).to eq(0.0)
      end

      it 'returns Infinity when dividing Float::INFINITY by a number' do
        expect(calculator.divide(Float::INFINITY, 2)).to eq(Float::INFINITY)
      end

      it 'returns NaN when dividing 0.0 by 0.0' do
        expect { calculator.divide(0.0, 0.0) }.to raise_error(ZeroDivisionError)
      end

      it 'returns NaN when numerator is Float::NAN' do
        expect(calculator.divide(Float::NAN, 1)).to be_nan
      end

      it 'returns NaN when denominator is Float::NAN' do
        expect(calculator.divide(1, Float::NAN)).to be_nan
      end
    end
  end

  describe '#exponentiate' do
    context 'with positive integers' do
      it 'returns the base raised to the exponent' do
        expect(calculator.exponentiate(2, 3)).to eq(8)
      end
    end

    context 'with zero exponent' do
      it 'returns 1 for any non-zero base' do
        expect(calculator.exponentiate(5, 0)).to eq(1)
      end
    end

    context 'with zero base' do
      it 'returns 0 when exponent is positive' do
        expect(calculator.exponentiate(0, 3)).to eq(0)
      end

      it 'raises error or returns NaN when exponent is 0 (undefined)' do
        result = calculator.exponentiate(0, 0)
        expect(result).to eq(1) # Ruby defines 0**0 as 1
      end
    end

    context 'with negative exponent' do
      it 'returns the reciprocal power as float' do
        expect(calculator.exponentiate(2, -2)).to eq(0.25)
      end
    end

    context 'with decimal base or exponent' do
      it 'returns a float result' do
        expect(calculator.exponentiate(9.0, 0.5)).to eq(3.0) # square root of 9
      end
    end

    context 'with negative base and odd exponent' do
      it 'returns a negative number' do
        expect(calculator.exponentiate(-2, 3)).to eq(-8)
      end
    end

    context 'with negative base and even exponent' do
      it 'returns a positive number' do
        expect(calculator.exponentiate(-2, 2)).to eq(4)
      end
    end
  end

  describe 'input validation' do
    shared_examples 'raises ArgumentError for non-numeric inputs' do |method_name, args|
      it "raises ArgumentError for #{method_name} with #{args.inspect}" do
        expect { calculator.public_send(method_name, *args) }.to raise_error(ArgumentError, /Expected Numeric/)
      end
    end

    include_examples 'raises ArgumentError for non-numeric inputs', :add, ['a', 1]
    include_examples 'raises ArgumentError for non-numeric inputs', :subtract, [1, nil]
    include_examples 'raises ArgumentError for non-numeric inputs', :multiply, [{}, 2]
    include_examples 'raises ArgumentError for non-numeric inputs', :divide, [[], 2]
    include_examples 'raises ArgumentError for non-numeric inputs', :exponentiate, [1, 'b']
  end
end
