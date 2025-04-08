# frozen_string_literal: true
module Services
  class BowlingService
    MAX_FRAMES = 10
    MAX_PINS = 10
    MAX_THROW = 2
    FIRST_PLAYER = :A

    def initialize
      @current_player = FIRST_PLAYER
      @players = {
        A: { frames: [] },
        B: { frames: [] }
      }

      reset
    end

    def roll(rolled_pins: Random.rand(0..MAX_PINS))
      @current_pins -= rolled_pins
      @remaining_throws -= 1

      next_player_action if @remaining_throws.zero?
    end

    private

    def next_player_action
      fill_current_frame
      reset
      switch_player
    end

    def fill_current_frame
      @players[current_player][:frames] << (MAX_PINS - @current_pins)
    end

    def switch_player
      @current_player = current_player == :A ? :B : :A
    end

    def current_player
      @current_player ||= :A
    end

    def reset
      @current_pins = MAX_PINS
      @remaining_throws = MAX_THROW
    end
  end
end
