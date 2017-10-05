class Fact < ApplicationRecord
    include ImageUploader::Attachment.new(:image)
    
    has_many :vote
end
