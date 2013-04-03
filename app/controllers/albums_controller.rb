class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(params[:album])

    if @album.save
      json = Jbuilder.encode do |json|
        json.partial render_to_string(
          'albums/_albums_list_item',
          layout: false,
          locals: { album: @album })
      end
    else
      json = Jbuilder.encode do |json|
        json.errors @album.errors.messages.to_json
      end
    end
    render json: json
  end

  def update_album
    @album = Album.find(params[:id])

    if @album.update_attributes(params[:album])
      json = Jbuilder.encode do |json|
        json.call(@album, :id, :name, :desc)
      end
    else
      json = Jbuilder.encode do |json|
        json.errors @album.errors.full_messages.to_json
      end
    end
    render json: json
  end

  def remove_album
    @album = Album.find(params[:id])
    @album.destroy
    render nothing: true
  end

  def add_image
    @image = Image.new(params[:album])

    if ! @image.save
      render nothing: true
    end
  end

  def remove_image
    @image = Image.find(params[:id])
    @image.destroy()
    render nothing: true
  end
end
