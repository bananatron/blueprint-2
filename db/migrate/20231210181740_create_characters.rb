class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters, id: :uuid do |t|
      t.string :name, null: false
      t.string :physical_description, null: false
      t.string :behavioral_description, null: false

      # Stats
      t.integer :health, null: false, default: 100
      t.integer :max_health, null: false, default: 100

      t.integer :energy, null: false, default: 100
      t.integer :max_energy, null: false, default: 100

      # Attributes
      t.integer :strength, null: false, default: 1
      t.integer :dexterity, null: false, default: 1
      t.integer :intelligence, null: false, default: 1

      # Location
      t.references :room, type: :uuid, foreign_key: true, null: false
      t.integer :x, null: false
      t.integer :y, null: false

      # Relations
      t.references :user, type: :uuid, foreign_key: true, null: false

      t.jsonb :meta, null: false, default: {}

      t.timestamps
    end
  end
end
