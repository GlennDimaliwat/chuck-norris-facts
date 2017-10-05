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

    # Fact should contain Chuck Norris
    validates_format_of :fact, :with => /Chuck Norris/i, :message => 'should contain Chuck Norris'

    scope :random_fact, -> {
        # Set a random offset
        offset = rand(Fact.count)

        # Get the random Fact
        @fact = Fact.offset(offset).first
    }

    scope :top10, ->{
        joins(:vote).
        group("facts.id").
        order("count(votes.id) DESC").
        limit(10)
    }
end
