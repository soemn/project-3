class CreateRedemptions < ActiveRecord::Migration[5.1]
  def change
    create_table :redemptions do |t|
      t.references :reward, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
