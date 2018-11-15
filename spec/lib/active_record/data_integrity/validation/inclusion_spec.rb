# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::Validation::Inclusion do
  describe '#call' do
    context 'when column has text data type' do
      let(:result) { described_class.new(Validation::UserInfo).call }

      it { expect(result).to be_falsey }
    end

    context 'when column has enum data type' do
      let(:result) { described_class.new(Validation::UserInfo2).call }

      it { expect(result).to be_truthy }
    end
  end
end
