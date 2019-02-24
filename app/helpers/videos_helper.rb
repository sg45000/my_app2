module VideosHelper
  def checked?(video,genre)
    video.genres.include?(genre)
  end
end
