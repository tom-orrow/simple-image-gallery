class RemoveImageColimnsFromImages < ActiveRecord::Migration
  def change
    remove_column :images, "image_file_name"
    remove_column :images, "image_content_type"
    remove_column :images, "image_file_size"
  end
end
