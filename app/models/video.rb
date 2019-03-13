class Video < ApplicationRecord
    URL_REGEX = /\Ahttps:\/\/www\.youtube\.com\/watch\?v=([\w-]+)\z/i
    validates :user_id, presence: true
    validates :name, presence: true, length:{maximum: 20}
    validates :url, presence: true
    validates :discription, length:{maximum: 255}
    has_and_belongs_to_many :genres
   
    
    def embed_url
        url = self.url.match(URL_REGEX)
        if !url.nil?
            "https://www.youtube.com/embed/"+url[1]
        end
    end
    
    def youtube_url
        self.url="https://www.youtube.com/watch?v="+self.url
    end
end
