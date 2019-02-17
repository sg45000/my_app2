class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.belongs_to :user,index: true
      t.string :name
      t.string :url
      t.integer :user_id
      t.string :discription

      t.timestamps
    end
  end
end
