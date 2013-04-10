class AlbumsController < ApplicationController
  include AlbumsHelper

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.create!(album_params)
    render json: { partial: render_to_string(
      'albums/_albums_list_item',
      layout: false,
      locals: { album: @album }
    )}
  rescue => e
    render json: { errors: e.record.errors }
  end

  def update_album
    @album = Album.find(params[:id])
    @album.update_attributes!(album_params)
    render json: @album.slice(:id, :name, :desc)
  rescue => e
    render json: { errors: e.record.errors }
  end

  def remove_album
    Album.find(params[:id]).destroy
    render nothing: true, status: :ok
  end

  def add_image
    i = image_params
    @image = Image.new(i)
    @image.save
  rescue => e
    ap e
    render json: { errors: e.record.errors }
  end

  def remove_image
    Image.find(params[:id]).destroy
    render nothing: true, status: :ok
  end
end
