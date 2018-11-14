# frozen_string_literal: true

module BelongsTo
  class UserSetting < ApplicationRecord
    belongs_to :user, class_name: 'BelongsTo::User'
  end
end
