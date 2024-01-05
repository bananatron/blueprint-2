class CreateLoots < ActiveRecord::Migration[7.1]
  def change
    create_table :loots, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.references :character, type: :uuid, foreign_key: true, null: true

      t.references :room, type: :uuid, foreign_key: true, null: true
      t.integer :x, null: true
      t.integer :y, null: true

      t.jsonb :meta, null: false, default: {}

      t.timestamps
    end
  end
end
