# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::Accordance::TablePresence do
  describe '#call' do
    context 'when model has it own table' do
      let(:result) { described_class.new(Accordance::NoTable).call }

      it { expect(result).to be_falsey }
    end

    context 'when model does not have its own table' do
      let(:result) do
        described_class.new(Accordance::User).call
      end

      it { expect(result).to be_truthy }
    end
  end
end
