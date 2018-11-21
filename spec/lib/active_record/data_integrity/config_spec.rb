# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveRecord::DataIntegrity::Config do
  let(:options) { Thor::CoreExt::HashWithIndifferentAccess.new }
  let(:config) { described_class.new(options) }

  before { ActiveRecord::Base.connection }

  describe '#cops' do
    context 'when option only is passed' do
      before { options[:only] = 'HasMany/ForeignKey' }

      it do
        expect(config.cops).to include(ActiveRecord::DataIntegrity::HasMany::ForeignKey)
        expect(config.cops).not_to include(ActiveRecord::DataIntegrity::BelongsTo::ForeignKey)
      end
    end

    context 'when option only is not passed' do
      it do
        expect(config.cops).to include(ActiveRecord::DataIntegrity::HasMany::ForeignKey)
        expect(config.cops).to include(ActiveRecord::DataIntegrity::BelongsTo::ForeignKey)
      end
    end
  end

  describe '#models' do
    before { BelongsTo::User && BelongsTo::UserSetting }

    context 'when option model_names is passed' do
      before { options[:model_names] = ['BelongsTo::User'] }

      it do
        expect(config.models).to include(BelongsTo::User)
        expect(config.models).not_to include(BelongsTo::UserSetting)
      end
    end

    context 'when option model_names is not passed' do
      it do
        expect(config.models).to include(BelongsTo::User)
        expect(config.models).to include(BelongsTo::UserSetting)
      end
    end
  end
end
