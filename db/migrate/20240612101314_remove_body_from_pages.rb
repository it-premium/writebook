class RemoveBodyFromPages < ActiveRecord::Migration[7.2]
  def change
    remove_column :pages, :body, :text
  end
end
