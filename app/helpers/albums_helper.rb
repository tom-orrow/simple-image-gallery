module AlbumsHelper
  def album_params
    params.require(:album).permit(:name, :desc)
  end

  def image_params
    # Bad code
    params.require(:image).permit!
    # params.require(:image).permit(:album_id, { file: [] })
  end
end
