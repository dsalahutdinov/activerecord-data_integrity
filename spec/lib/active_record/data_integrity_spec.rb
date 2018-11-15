# frozen_string_literal: true

RSpec.describe ActiveRecord::DataIntegrity do
  it 'has a version number' do
    expect(ActiveRecord::DataIntegrity::VERSION).not_to be_nil
  end
end
