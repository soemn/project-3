class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :profile_picture, :string
    add_column :users, :slug, :string
    add_column :users, :spent_points, :integer
  end
end
