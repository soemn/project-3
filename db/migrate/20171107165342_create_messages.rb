class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :type
      t.references :user, foreign_key: true
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
