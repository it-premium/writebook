class CreateAccesses < ActiveRecord::Migration[7.2]
  def change
    create_table :accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :level, null: false

      t.timestamps
    end

    add_index :accesses, [ :user_id, :book_id ], unique: true
  end
end
