class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters, id: :uuid do |t|
      t.string :name, null: false
      t.string :role, null: false

      # Locale
      t.references :room, type: :uuid, foreign_key: true, null: false
      t.integer :x, null: false
      t.integer :y, null: false

      t.datetime :ready_to_start, null: true

      t.jsonb :meta, null: false, default: {}

      t.references :user, type: :uuid, foreign_key: true, null: false
      t.references :session, type: :uuid, foreign_key: true, null: false

      t.timestamps
    end
  end
end
