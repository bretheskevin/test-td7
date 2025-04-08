# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Services::BowlingService do
  let(:service) { Services::BowlingService.new }

  describe 'constant values' do
    it 'MAX_FRAMES is 10' do
      expect(Services::BowlingService::MAX_FRAMES).to eq(10)
    end

    it 'MAX_PINS is 10' do
      expect(Services::BowlingService::MAX_PINS).to eq(10)
    end

    it 'MAX_THROW is 2' do
      expect(Services::BowlingService::MAX_THROW).to eq(2)
    end
  end

  describe '#reset' do
    before do
      service.instance_variable_set(:@current_pins, 5)
      service.instance_variable_set(:@remaining_throws, 3)
      service.instance_variable_set(:@current_player, :Z)

      service.send(:reset)
    end

    it 'resets the current player' do
      expect(service.instance_variable_get(:@current_player)).to eq(:A)
    end

    it 'resets the current pins' do
      expect(service.instance_variable_get(:@current_pins)).to eq(Services::BowlingService::MAX_PINS)
    end

    it 'resets the remaining throws' do
      expect(service.instance_variable_get(:@remaining_throws)).to eq(Services::BowlingService::MAX_THROW)
    end
  end
end
