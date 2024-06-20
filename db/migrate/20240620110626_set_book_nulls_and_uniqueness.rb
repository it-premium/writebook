class SetBookNullsAndUniqueness < ActiveRecord::Migration[8.0]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :slug, false

    remove_index :books, :slug
  end
end
