class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.column "name", :string
      t.timestamps
    end
  end

  def down
    drop_table :albums
  end
end
