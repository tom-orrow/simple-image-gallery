class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.column "src", :string
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
