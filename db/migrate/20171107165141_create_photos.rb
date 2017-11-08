class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.references :brand, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
