class ChangeDescColumnType < ActiveRecord::Migration
  def up
    change_column :albums, :desc, :text, :limit => nil
  end
end
