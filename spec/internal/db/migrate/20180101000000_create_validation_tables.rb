# frozen_string_literal: true

class CreateValidationTables < ActiveRecord::Migration[5.2]
  def change
    create_table :validation_users do |t|
      t.text :email

      t.timestamps
    end

    create_table :validation_user_infos do |t|
      t.text :language, null: false, default: 'en'
    end

    execute <<-DDL
      create type validation_language as ENUM ('en', 'fr', 'es');
    DDL
    create_table :validation_user_info2s do |t|
      t.column :language, :validation_language, null: false, default: 'en'
    end
  end
end
