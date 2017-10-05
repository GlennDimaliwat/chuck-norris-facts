require 'rails_helper'

RSpec.describe Fact, type: :model do

  it "should disallow empty Chuck Norris fact" do
    expect(Fact.new(fact: "", image_data: "dummy image")).to be_invalid
  end

  it "should disallow empty Chuck Norris photo" do
    expect(Fact.new(fact: "dummy fact", image_data: "")).to be_invalid
  end

  it "should allow Chuck Norris facts which are less than or equal to 300 characters" do
    expect(Fact.new(fact: "Hello World", image_data: "dummy image")).to be_valid
    expect(Fact.new(fact: "The woodchuck chuck if a woodchuck could Chuck Norris", image_data: "dummy image")).to be_valid
    expect(Fact.new(fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.", image_data: "dummy image")).to be_valid

    example_fact = ""
    (1..300).each {
      example_fact += "a"
      expect(Fact.new(fact: example_fact, image_data: "dummy image")).to be_valid
    }
  end

  it "should disallow Chuck Norris facts greater than 300 characters" do
    expect(Fact.new(fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid
    expect(Fact.new(fact: "Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid
    expect(Fact.new(fact: "magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid

    example_fact = "a" * 300
    (301..600).each {
      example_fact += "a"
      expect(Fact.new(fact: example_fact, image_data: "dummy image")).to be_invalid
    }
  end

  it "should disallow duplicate facts about Chuck Norris" do    
    post1 = Fact.new(fact: "Chuck Norris doesnt sleep. He waits.", image_data: "dummy image")
    post1.save
    post2 = Fact.new(fact: "Chuck Norris doesnt sleep. He waits.", image_data: "dummy image") 
    expect(post2).to be_invalid

    post3 = Fact.new(fact: "Chuck Norris was bitten by a cobra and after five days of excruciating pain... the cobra died.", image_data: "dummy image")
    post3.save
    post4 = Fact.new(fact: "Chuck Norris was bitten by a cobra and after five days of excruciating pain... the cobra died.", image_data: "dummy image") 
    expect(post4).to be_invalid
  end

end
