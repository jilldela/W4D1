class ArtworksController < ApplicationController
  def index
    @artworks = []
    artworks_shared = ArtworkShare.find_by(viewer_id: params[:user_id])
    artwork_owned = Artwork.find_by(artist_id: params[:user_id])

    @artworks << artworks_shared if artworks_shared
    @artworks << artwork_owned if artwork_owned
    render json: @artworks
  end

  def create
    @artwork = Artwork.new(artwork_params)

    if @artwork.save!
      render json: @artwork
    else
      render(
        json: @artwork.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @artwork = Artwork.find_by(id: params[:id])
    render json: @artwork
  end

  def update
    @artwork = Artwork.find_by(id: params[:id])
    @artwork.update!(artwork_params)
    render json: @artwork
  end

  def destroy
    @artwork = Artwork.find_by(id: params[:id])
    @artwork.destroy
    # redirect_to users_url, status: 303
    render json: @artwork
  end

  private

  def artwork_params
    params.require(:artwork).permit(:artist_id)
  end

end
