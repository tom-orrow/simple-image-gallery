class AddAlbumIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :album_id, :integer
  end

  def down
    remove_column :images, :album_id
  end
end
