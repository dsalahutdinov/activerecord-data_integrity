# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dbcop::Validation::Presence do
  describe '#call' do
    context 'presence validation with nullable column' do
      let(:result) { described_class.new(User).call }

      it { expect(result).to be_falsey }
    end
  end
end
