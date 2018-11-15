# frozen_string_literal: true

module HasMany
  class Address < ApplicationRecord
    has_many :phones, class_name: 'HasMany::Phone'
  end
end
