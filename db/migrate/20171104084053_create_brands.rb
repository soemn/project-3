class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :logo
      t.string :link

      t.timestamps
    end
  end
end
