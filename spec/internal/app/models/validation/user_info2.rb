# frozen_string_literal: true

module Validation
  class UserInfo2 < ApplicationRecord
    validates :language, presence: true, inclusion: { in: %(en fr es) }
  end
end
