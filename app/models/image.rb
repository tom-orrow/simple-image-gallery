class Image < ActiveRecord::Base
  attr_accessible :album_id
  attr_accessible :image
  has_attached_file :image, styles: { :original => "800x600>", :thumb => "80x80#" }, default_style: :original
  validate :file_dimensions, :unless => "errors.any?"
  belongs_to :album

  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(file.queued_for_write[:original].path)
    if dimensions.width < 160 || dimensions.height < 160
      errors.add(:file,'Width and height must be at least 160px')
    end
  end
end
