class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :measure
      t.boolean :done
      t.references :train, null: false, foreign_key: true

      t.timestamps
    end
  end
end
