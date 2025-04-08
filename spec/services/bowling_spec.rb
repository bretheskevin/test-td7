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

    it 'resets the current pins' do
      expect(service.instance_variable_get(:@current_pins)).to eq(Services::BowlingService::MAX_PINS)
    end

    it 'resets the remaining throws' do
      expect(service.instance_variable_get(:@remaining_throws)).to eq(Services::BowlingService::MAX_THROW)
    end
  end

  describe '#switch_player and #current_player' do
    it 'current_player is default' do
      expect(service.send(:current_player)).to eq(:A)
    end

    it 'current_player is changed' do
      service.send(:switch_player)
      expect(service.send(:current_player)).to eq(:B)
    end

    it 'go back to player A' do
      service.send(:switch_player)
      service.send(:switch_player)
      expect(service.send(:current_player)).to eq(:A)
    end
  end

  describe '#roll' do
    describe 'switch player after MAX_THROW is reached' do
      context 'when MAX_THROW is 2 and roll method is called once' do
        before do
          service.roll(rolled_pins: 1)
        end

        it 'player A is the current player' do
          expect(service.send(:current_player)).to eq(:A)
        end
      end

      context 'when MAX_THROW is 2 and roll method is called twice' do
        before do
          2.times { service.roll(rolled_pins: 1) }
        end

        it 'player A is still the current player' do
          expect(service.send(:current_player)).to eq(:A)
        end
      end

      context 'when MAX_THROW is 2 and roll method is called three times' do
        before do
          3.times { service.roll(rolled_pins: 1) }
        end

        it 'switches to player B' do
          expect(service.send(:current_player)).to eq(:B)
        end
      end
    end

    describe '@players frame score' do
      it 'total number of rolled pins' do
        2.times { service.roll(rolled_pins: 1) }
        expect(service.instance_variable_get(:@players)[:A][:frames]).to eq([1, 1])
      end

      it 'total number of rolled pins' do
        5.times { service.roll(rolled_pins: 1) }
        expect(service.instance_variable_get(:@players)[:A][:frames]).to eq([1, 1, 1])
      end
    end
  end
end
