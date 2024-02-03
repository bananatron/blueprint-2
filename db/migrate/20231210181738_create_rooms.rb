class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name, null: false
      t.string :description
      t.string :zone_group_tag

      t.integer :width, null: false, default: 10
      t.integer :height, null: false, default: 10

      t.uuid :room_east_id, null: true
      t.uuid :room_west_id, null: true
      t.uuid :room_south_id, null: true
      t.uuid :room_north_id, null: true

      t.jsonb :meta, null: false, default: {}
    end

    add_index :rooms, :room_east_id
    add_index :rooms, :room_west_id
    add_index :rooms, :room_south_id
    add_index :rooms, :room_north_id
    add_index :rooms, :zone_group_tag

    add_foreign_key :rooms, :rooms, column: :room_east_id
    add_foreign_key :rooms, :rooms, column: :room_west_id
    add_foreign_key :rooms, :rooms, column: :room_south_id
    add_foreign_key :rooms, :rooms, column: :room_north_id
  end
end
