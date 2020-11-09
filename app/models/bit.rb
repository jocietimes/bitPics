class Bit < ApplicationRecord
    validates :message, presence: true
    validates :pics, presence: true
    has_many :comments

    belongs_to :user
    mount_uploader :pics, PicsUploader
end
