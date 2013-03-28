class RemoveSrcFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :src
  end
end
