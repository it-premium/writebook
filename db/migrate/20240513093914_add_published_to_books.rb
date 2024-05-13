class AddPublishedToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :published, :boolean, default: false, null: false
    add_index :books, :published
  end
end
