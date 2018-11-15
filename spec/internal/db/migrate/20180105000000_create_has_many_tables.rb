# frozen_string_literal: true

class CreateHasManyTables < ActiveRecord::Migration[5.2]
  def change
    create_table :has_many_users, &:timestamps

    create_table :has_many_addresses do |t|
      t.references :user, foreign_key: { to_table: :has_many_users }
      t.text :data

      t.timestamps
    end

    create_table :has_many_phone do |t|
      t.references :address, foreign_key: false
    end
  end
end
