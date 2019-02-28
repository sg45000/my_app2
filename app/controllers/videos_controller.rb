class VideosController < ApplicationController
  before_action :video_owner? , only:[:edit,:update]
  
  def index
    @genres = Genre.all
    if params[:genre_id]
      @videos=Video.includes(:genres).where(genres_videos:{genre_id: params[:genre_id]})
      .references(:genres).paginate(page: params[:page],per_page: 5)
    else
      @videos = Video.all.paginate(page: params[:page],per_page: 5)
    end
  end
  
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
  
  def video_owner?
    video=Video.find_by(id: params[:id])
    if !video
      flash[:danger] = "This video has been removed."
      redirect_to root_url
    elsif video.user_id!=session[:user_id]
      flash[:danger] = "Please log in correct account before access this page."
      redirect_to login_url
    else
      
    end
  end
  
end
