class User < ApplicationRecord
    has_many :videos
    has_many :active_relationships, class_name:  "UserRelation",
                                foreign_key: "follower_id",
                                dependent: :delete_all
    has_many :passive_relationships, class_name: "UserRelation",
                                foreign_key: "followed_id",
                                dependent: :delete_all
    has_many :following, through: :active_relationships, source: :followed
    #followingを単数形で外部キ-で探してしまうため、sourceをfollowed指定する
    has_many :followers, through: :passive_relationships, source: :follower
    #followersの単数形はfollowerなのでsourceは明示する必要はない
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
    
    def follow(other_user)
        following << other_user
    end
    
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    def followed?(other_user)
        following.include?(other_user)
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
