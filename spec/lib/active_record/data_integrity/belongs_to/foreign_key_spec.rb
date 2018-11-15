# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::BelongsTo::ForeignKey do
  describe '#call' do
    context 'when there is fereign key to the parent table' do
      let(:result) do
        described_class.new(BelongsTo::UserSetting).call
      end

      it { expect(result).to be_truthy }
    end

    context 'when there is no foreign key to the parent table' do
      let(:result) { described_class.new(BelongsTo::UserUnconstraintable).call }

      it { expect(result).to be_falsey }
    end
  end
end
