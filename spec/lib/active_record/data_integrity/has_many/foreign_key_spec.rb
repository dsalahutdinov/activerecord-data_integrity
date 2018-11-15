# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::HasMany::ForeignKey do
  describe '#call' do
    context 'when there is fereign key to the parent table' do
      let(:result) do
        described_class.new(HasMany::User).call
      end

      it { expect(result).to be_truthy }
    end

    context 'when there is no foreign key to the parent table' do
      let(:result) { described_class.new(HasMany::Address).call }

      it { expect(result).to be_falsey }
    end
  end
end
