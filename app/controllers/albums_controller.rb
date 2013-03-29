class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    ap @album.images
  end

  def create
    @album = Album.new(params[:album])

    if @album.save
      render :json => {
        partial: render_to_string(
          'albums/_albums_list_item',
          layout: false,
          locals: { :album => @album })}
    else
      render nothing: true
    end
  end

  def update_album
    @album = Album.find(params[:id])

    if @album.update_attributes(params[:album])
      render :json => { id: @album.id, name: @album.name, desc: @album.desc }
    else
      render nothing: true
    end
  end

  def remove_album
    @album = Album.find(params[:id])
    @album.destroy
    render nothing: true
  end

  def add_image
    @image = Image.create( params[:album] )
  end

  def remove_image
    @image = Image.find( params[:id] )
    @image.destroy()
    render nothing: true
  end
end
