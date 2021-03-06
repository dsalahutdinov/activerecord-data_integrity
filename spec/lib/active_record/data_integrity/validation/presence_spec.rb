# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::Validation::Presence do
  describe '#call' do
    context 'when validation is present with nullable column' do
      let(:result) { described_class.new(Validation::User).call }

      it { expect(result).to be_falsey }
    end
  end
end
