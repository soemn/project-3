class RenameMessageToInteraction < ActiveRecord::Migration[5.1]
  def change
    rename_table :messages, :interactions
  end
end
