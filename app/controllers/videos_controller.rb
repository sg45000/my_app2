class VideosController < ApplicationController
  
  def new
    @video=Video.new
    @genres=Genre.all
  end
  
  def create
    @video = Video.new(video_params)
    genre_params['genres'].each do |genre|
      @video.genres << Genre.find(genre)
    end
    @video.user_id=current_user.id
    if @video.save
      redirect_to current_user
    else
      render 'new'
    end
    
  end
  
  def edit
    @video=Video.find(params[:id])
    @genres=Genre.all
  end
  
  def update
    @video=Video.find(params[:id])
    @video.genres.delete_all
    genre_params['genres'].each do |genre|
      @video.genres << Genre.find(genre)
    end
    if @video.update_attributes(video_params)
      redirect_to current_user
    else
      @genres=Genre.all
      render 'new'
    end
  end
  
  private
  
  def video_params
    params.require(:video).permit(:name,:url,:discription)
  end
  
  #genres[]はgenre.idのArray
  def genre_params
    params.require(:video).permit(genres:[])
  end
  
end
