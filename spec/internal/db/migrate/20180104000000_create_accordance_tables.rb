# frozen_string_literal: true

class CreateAccordanceTables < ActiveRecord::Migration[5.2]
  def change
    create_table :accordance_users, &:timestamps
  end
end
