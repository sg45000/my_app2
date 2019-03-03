class User < ApplicationRecord
    has_many :videos
    validates :name , presence: true, length: {maximum: 20}
    EMAIL_REGEX = /\A[\w\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: true
    validates :password, presence: true
    attr_accessor :remenber_token
    has_secure_password
    
    def remenber
        self.remenber_token = User.new_token
        self.update_attribute(:remenber_digest, User.digest(remenber_token))
    end
    
    def forget
        self.update_attribute(:remenber_digest, nil)
    end
    
    def authenticated?(remenber_token)
        return false if remenber_digest.nil?  
        BCrypt::Password.new(remenber_digest) == remenber_token

    end
    
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
    
        def new_token 
            SecureRandom.urlsafe_base64
        end
    end
end
