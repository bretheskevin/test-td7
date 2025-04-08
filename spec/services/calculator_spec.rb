require 'spec_helper'

RSpec.describe ::Services::CalculatorService do
  subject(:calculator) { described_class.new }

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
    end

    context 'when dividing by zero' do
      it 'raises ZeroDivisionError' do
        expect { calculator.divide(5, 0) }.to raise_error(ZeroDivisionError)
      end
    end
  end
end
