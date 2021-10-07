class Task < ApplicationRecord
    validates :title, presence: {message: "is required"}, length: {minimum:3, maximum:30, too_long: "is too long", too_short: "is too short"}
    validates :description, presence: {message: "is required"}
    validates :expiredDate, presence: {message: "is required"}
    

    scope :order_by_created_at, -> {order(created_at: :desc)}
    scope :order_by_deadline, -> {order(expiredDate: :desc)}
    scope :order_by_status, ->(status){where(status: status)}
    scope :order_by_priority_link, ->{order(priority: :desc)}
    scope :search_with_title, ->(title){where("title LIKE ?", "%#{title}%")}

    paginates_per 5
    enum priority:
    {
        "Low": 0,
        "Medium": 1,
        "High": 2
    }

    enum status:
    {
        "Unstarted": 0,
        "In progress": 1,
        "Completed": 2
    }

    belongs_to :user
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings, source: :tag
end
