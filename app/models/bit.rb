class Bit < ApplicationRecord
    validates :message, presence: true

    belongs_to :user
    mount_uploader :pics, PicsUploader
end
