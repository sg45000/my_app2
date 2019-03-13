class AddIndexToGenresVideos < ActiveRecord::Migration[5.2]
  def change
    add_index :genres_videos, [:genre_id,:video_id], unique: true 
  end
end
