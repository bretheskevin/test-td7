module Services
  class BowlingService
    MAX_FRAMES = 10

    def initialize
      @rolls = []
    end

    def roll(pins)
      raise "Invalid number of pins" if pins < 0 || pins > 10
      @rolls << pins
    end

    # Calcule le score total de la partie
    def score
      total = 0
      roll_index = 0

      MAX_FRAMES.times do
        if strike?(roll_index)
          total += 10 + strike_bonus(roll_index)
          roll_index += 1
        elsif spare?(roll_index)
          total += 10 + spare_bonus(roll_index)
          roll_index += 2
        else
          total += frame_score(roll_index)
          roll_index += 2
        end
      end

      total
    end

    private

    def strike?(index)
      @rolls[index] == 10
    end

    def spare?(index)
      @rolls[index] + @rolls[index + 1] == 10
    end

    def strike_bonus(index)
      @rolls[index + 1].to_i + @rolls[index + 2].to_i
    end

    def spare_bonus(index)
      @rolls[index + 2].to_i
    end

    def frame_score(index)
      @rolls[index].to_i + @rolls[index + 1].to_i
    end
  end
end
