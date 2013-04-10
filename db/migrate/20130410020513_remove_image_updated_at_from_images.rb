class RemoveImageUpdatedAtFromImages < ActiveRecord::Migration
  def change
    remove_column :images, "image_updated_at"
  end
end
