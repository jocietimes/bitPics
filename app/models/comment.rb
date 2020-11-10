class Comment < ApplicationRecord
    validates :message, presence: true

    belongs_to :bit
    belongs_to :user
end
