class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  process :resize_to_limit => [800, 600]

  version :thumb do
    process :resize_to_fill => [80,80]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/no_photo.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
