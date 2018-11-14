# frozen_string_literal: true

class CreateValidationTables < ActiveRecord::Migration[5.2]
  def change
    create_table :validation_users do |t|
      t.text :email

      t.timestamps
    end
  end
end
