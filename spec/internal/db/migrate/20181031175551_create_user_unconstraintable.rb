# frozen_string_literal: true

class CreateUserUnconstraintable < ActiveRecord::Migration[5.2]
  def change
    create_table :belongs_to_user_unconstraintable do |t|
      t.references :user, foreign_key: false
    end
  end
end
