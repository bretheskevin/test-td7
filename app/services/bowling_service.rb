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
      if @remaining_throws.positive?
        @current_pins -= rolled_pins
        @remaining_throws -= 1
        @players[current_player][:frames] << rolled_pins
      end

      reset
      switch_player
    end

    private

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

    def print_frames
      @players.each do |player, data|
        pp '|=================='
        pp "|#{player}: #{data[:frames].join(', ')}"
        pp '|=================='
        pp ''
      end
    end
  end
end
