# frozen_string_literal: true

class CreateAccordanceTables < ActiveRecord::Migration[5.2]
  def change
    create_table :accordance_users, &:timestamps

    create_table :accordance_data, id: false do |t|
      t.integer :short_id, primary: true, limit: 4
      t.timestamps
    end
    execute %Q{ ALTER TABLE "accordance_data" ADD PRIMARY KEY ("short_id"); }
  end
end
