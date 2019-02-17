class User < ApplicationRecord
    has_many :videos
    validates :name , presence: true, length: {maximum: 20}
    EMAIL_REGEX = /\A[\w\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: true
    
    validates :password, presence: true
    
    has_secure_password
    class<<self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
    
        def new_token 
            SecureRandom.urlsafe_base64
        end
        
    end
    
end
