# frozen_string_literal: true

class CreateBelongsToTables < ActiveRecord::Migration[5.2]
  def change
    create_table :belongs_to_users, &:timestamps

    create_table :belongs_to_user_settings do |t|
      t.references :user, foreign_key: { to_table: :belongs_to_users }
      t.text :data

      t.timestamps
    end

    create_table :belongs_to_user_unconstraintable do |t|
      t.references :user, foreign_key: false
    end
  end
end
