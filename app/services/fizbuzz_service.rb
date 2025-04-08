module Services
  class FizbuzzService

    def self.call(n, use_log = false)
      result = (1..n).map do |i|
        case
        when i % 15 == 0
          "FizzBuzz"
        when i % 3 == 0
          "Fizz"
        when i % 5 == 0
          "Buzz"
        else
          i.to_s
        end
      end

      result.each { |r| pp r } if use_log

      result
    end

  end
end
