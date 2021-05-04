class AddForeignKeyToTrains < ActiveRecord::Migration[6.1]
  def change
    add_reference :trains, :user, foreign_key: true
  end
end
