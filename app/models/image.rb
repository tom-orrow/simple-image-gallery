class Image < ActiveRecord::Base
  belongs_to :album
  mount_uploader :file, ImageUploader
  validates_presence_of :file
end
