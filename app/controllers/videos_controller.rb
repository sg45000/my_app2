class VideosController < ApplicationController
  
  def new
    @video=Video.new
  end
  
  def create
    @video = Video.new(video_params)
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
  
end
