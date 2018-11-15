# frozen_string_literal: true

module HasMany
  class User < ApplicationRecord
    has_many :addresses, class_name: 'HasMany::Address'
  end
end
