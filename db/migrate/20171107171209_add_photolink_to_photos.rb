class AddPhotolinkToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_link, :string
  end
end
