class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :required_points
      t.string :photo_link

      t.timestamps
    end
  end
end
