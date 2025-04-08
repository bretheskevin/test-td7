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
end
