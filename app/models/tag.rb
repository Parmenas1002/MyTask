class Tag < ApplicationRecord
    validates :name, presence: {message: "is required"}
    has_many :taggings, dependent: :destroy
    has_many :tasks, through: :taggings, source: :task
end
