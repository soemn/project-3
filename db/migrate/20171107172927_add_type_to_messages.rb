class AddTypeToMessages < ActiveRecord::Migration[5.1]
  def change
    change_table :messages do |t|
      t.rename :type, :message_type
    end
  end
end
