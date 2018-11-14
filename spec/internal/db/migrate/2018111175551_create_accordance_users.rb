# frozen_string_literal: true

class CreateAccordanceUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :accordance_users, &:timestamps
  end
end
