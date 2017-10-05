require 'rails_helper'

RSpec.describe Vote, type: :model do

    it "should disallow voting of empty facts" do
        expect(Vote.new).to be_invalid
    end

    it "should allow voting of non-empty facts" do
        expect(Vote.new(fact:Fact.new(fact:"dummy fact", image_data:"dummy_image"))).to be_valid
    end
    
end
