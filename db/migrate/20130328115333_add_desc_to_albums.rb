class AddDescToAlbums < ActiveRecord::Migration
  def up
    add_column :albums, :desc, :string
  end

  def down
    remove_column :albums, :desc
  end
end
