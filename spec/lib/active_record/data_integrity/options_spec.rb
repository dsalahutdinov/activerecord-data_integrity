# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::Options do
  describe '#only' do
    subject(:only) { described_class.new(argv).only }

    context 'when only was passed' do
      let(:argv) { ['--only', 'BelongsTo/ForeignKey'] }

      it 'parses one cop is array' do
        expect(only).to match_array(['BelongsTo/ForeignKey'])
      end
    end

    context 'when only was passed as several values' do
      let(:argv) { ['--only', 'BelongsTo/ForeignKey,HasMany/ForeignKey'] }

      it 'parses one cop is array' do
        expect(only).to match_array(['BelongsTo/ForeignKey', 'HasMany/ForeignKey'])
      end
    end

    context 'when no option passed' do
      let(:argv) { [] }

      it 'parses one cop is array' do
        expect(only).to be_empty
      end
    end

    context 'when no only option values passed' do
      let(:argv) { ['--only', ''] }

      it 'parses one cop is array' do
        expect(only).to be_empty
      end
    end
  end
end
