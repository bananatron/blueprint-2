class CreateChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_messages, id: :uuid do |t|
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.references :character, null: true, foreign_key: true, type: :uuid

      t.string :channel, null: false
      t.text :body, null: false
      t.jsonb :tags, null: false, default: []
      t.jsonb :meta, null: false, default: {}

      t.timestamps
    end
  end
end
