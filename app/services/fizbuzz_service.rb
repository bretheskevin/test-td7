# frozen_string_literal: true
module Services
  class FizbuzzService

    def self.call(n, use_log: false)
      result = (1..n).map { |i| from_number(i) }

      result.each { |r| pp r } if use_log

      result
    end

    private

    def self.from_number(n)
      if (n % 15).zero?
        'FizzBuzz'
      elsif (n % 3).zero?
        'Fizz'
      elsif (n % 5).zero?
        'Buzz'
      else
        n.to_s
      end
    end
  end
end
