class Task < ApplicationRecord
    validates :title, presence: {message: "is required"}, length: {minimum:3, maximum:30, too_long: "is too long", too_short: "is too short"}
    validates :description, presence: {message: "is required"}
end
