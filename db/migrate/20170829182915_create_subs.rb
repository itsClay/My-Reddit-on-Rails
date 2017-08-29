class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :title, null: true
      t.string :description, null: true
      t.integer :moderator_id, null: true

      t.timestamps
    end
    add_index :subs, :moderator_id
  end
end
