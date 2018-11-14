# frozen_string_literal: true

module Validation
  class User < ApplicationRecord
    validates :email, presence: true
  end
end
