class User < ApplicationRecord
    
    validates :name, presence:true, length: {minimum:3, maximum:30}
    validates :email, presence:true, length: { maximum:255 }, 
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                uniqueness: true      
    validates :password, presence: true, length: { minimum:8 }, unless: Proc.new { |user| user.password.blank? }
    has_secure_password
    has_many :tasks, dependent: :destroy

   
    
end
