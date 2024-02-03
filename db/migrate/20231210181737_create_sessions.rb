class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions, id: :uuid do |t|
      t.string :invite_code, null: false
      t.datetime :started_at, null: true
      t.jsonb :meta, null: false, default: {}

      t.uuid :host_user_id, null: false

      t.timestamps
    end

    add_index :sessions, :invite_code
    add_index :sessions, :host_user_id
  end
end
