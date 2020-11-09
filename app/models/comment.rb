class Comment < ApplicationRecord
    validates :message, presence: true

    belongs_to :user
    belongs_to :bit
end
