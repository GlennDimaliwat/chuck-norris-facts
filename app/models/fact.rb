class Fact < ApplicationRecord
    include ImageUploader::Attachment.new(:image)
    
    has_many :vote

    # Fact should not be empty
    validates :fact, presence: true
    
    # Image should not be empty
    validates :image_data, presence: true

    # Fact should not exceed 300 characters
    validates :fact, length: { maximum: 300 }

    # Fact should not allow duplicates
    validates :fact, uniqueness: true

end
