require 'rails_helper'

use_log = false

RSpec.describe Services::FizbuzzService do
  describe '.call' do
    it 'returns "1" for n = 1' do
      expect(described_class.call(1, use_log)).to eq(%w[1])
    end

    it 'returns correct sequence for n = 5' do
      expect(described_class.call(5, use_log)).to eq(%w[1 2 Fizz 4 Buzz])
    end

    it 'returns "FizzBuzz" for multiples of 15' do
      result = described_class.call(15, use_log)
      expect(result[14]).to eq("FizzBuzz")
    end

    it 'returns "Fizz" only for multiples of 3 (not 15)' do
      result = described_class.call(6, use_log)
      expect(result[2]).to eq("Fizz")
      expect(result[5]).to eq("Fizz")
    end

    it 'returns "Buzz" only for multiples of 5 (not 15)' do
      result = described_class.call(10, use_log)
      expect(result[4]).to eq("Buzz")
      expect(result[9]).to eq("Buzz")
    end

    it 'returns numbers as strings when not divisible by 3 or 5' do
      result = described_class.call(2, use_log)
      expect(result).to eq(%w[1 2])
    end

    context "when n = 15" do
      it "returns '1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz'" do
        result = described_class.call(15, use_log)
        expect(result).to eq( %w[1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz])
      end
    end
  end
end
