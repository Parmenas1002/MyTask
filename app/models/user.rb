class User < ApplicationRecord
    before_update :destroy_admin
    before_create :destroy_admin
    validates :name, presence:true, length: {minimum:3, maximum:30}
    validates :email, presence:true, length: { maximum:255 }, 
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                uniqueness: true      
    validates :password, presence: true, length: { minimum:8 }, unless: Proc.new { |user| user.password.blank? }
    has_secure_password
    has_many :tasks, dependent: :destroy

    private
    def destroy_admin
        if self.admin 
            User.update_all(admin: 0)
        end
    end
end
