class Image < ActiveRecord::Base
  attr_accessible :album_id
  attr_accessible :image
  has_attached_file :image, styles: { :original => "800x600>", :thumb => "80x80#" }, default_style: :original
  belongs_to :album
end
