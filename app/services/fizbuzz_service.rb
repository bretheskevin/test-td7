# frozen_string_literal: true
module Services
  class FizbuzzService

    def self.call(n, use_log: false)
      result = (1..n).map do |i|
        if (i % 15).zero?
          'FizzBuzz'
        elsif (i % 3).zero?
          'Fizz'
        elsif (i % 5).zero?
          'Buzz'
        else
          i.to_s
        end
      end

      result.each { |r| pp r } if use_log

      result
    end

  end
end
