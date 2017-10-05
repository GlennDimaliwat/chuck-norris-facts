class Vote < ApplicationRecord
  belongs_to :fact

  # Fact should not be empty
  # validates :fact, presence: true
end
