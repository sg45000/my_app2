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
    @video.embed_url
    if @video.save
      redirect_to current_user
    else
      render 'new'
    end
    
  end
  
  private
  
  def video_params
    params.require(:video).permit(:name,:url,:discription)
  end
  
  def genre_params
    params.require(:video).permit(genres:[])
  end
  
end
