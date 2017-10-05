require 'rails_helper'

RSpec.describe Fact, type: :model do

  it "should disallow empty Chuck Norris fact" do
    expect(Fact.new(fact: "", image_data: "dummy image")).to be_invalid
  end

  it "should disallow empty Chuck Norris photo" do
    expect(Fact.new(fact: "Chuck Norris", image_data: "")).to be_invalid
  end

  it "should allow Chuck Norris facts which are less than or equal to 300 characters" do
    expect(Fact.new(fact: "Chuck Norris", image_data: "dummy image")).to be_valid
    expect(Fact.new(fact: "The woodchuck chuck if a woodchuck could Chuck Norris", image_data: "dummy image")).to be_valid
    expect(Fact.new(fact: "Chuck Norris dolor sit amet, coiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.", image_data: "dummy image")).to be_valid

    example_fact = "Chuck Norris"
    (13..300).each {
      example_fact += "a"
      expect(Fact.new(fact: example_fact, image_data: "dummy image")).to be_valid
    }
  end

  it "should disallow Chuck Norris facts greater than 300 characters" do
    expect(Fact.new(fact: "Chuck Norris or sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid
    expect(Fact.new(fact: "Chuck Norris. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid
    expect(Fact.new(fact: "Chuck NOrris parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu", image_data: "dummy image")).to be_invalid

    example_fact = "Chuck Norris"
    example_fact = "a" * 288
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

  it "should mention 'Chuck Norris'" do
    # expect(Fact.new(fact: "Chuck Norris doesn't sleep. He waits.").fact).to match(/Chuck Norris/i)
    # expect(Fact.new(fact: "chuck Norris doesn't sleep. He waits.").fact).to match(/Chuck Norris/i)
    # expect(Fact.new(fact: "Chuck norris doesn't sleep. He waits.").fact).to match(/Chuck Norris/i)
    # expect(Fact.new(fact: "chuck norris doesn't sleep. He waits.").fact).to match(/Chuck Norris/i)

    post1 = Fact.new(fact: "John Cena doesnt sleep. He waits.", image_data: "dummy image")
    expect(post1).to be_invalid
    post2 = Fact.new(fact: "Chuck doesnt sleep. He waits.", image_data: "dummy image") 
    expect(post2).to be_invalid
    post3 = Fact.new(fact: "He doesnt sleep. He waits.", image_data: "dummy image")
    expect(post3).to be_invalid
    post4 = Fact.new(fact: "The dog doesn't sleep. He waits.", image_data: "dummy image") 
    expect(post4).to be_invalid
  end

  it "should find the random Chuck Norris fact" do
    post1 = Fact.new(fact: "Chuck Norris doesnt sleep. He waits.", image_data: "dummy image")
    post1.save
    post2 = Fact.new(fact: "Chuck Norris was bitten by a cobra and after five days of excruciating pain... the cobra died.", image_data: "dummy image")
    post2.save
    post3 = Fact.new(fact: "When Chuck Norris turned 18, his parents moved out.", image_data: "dummy image")
    post3.save
    post4 = Fact.new(fact: "Chuck Norris has already been to Mars. That's why there are no signs of life.", image_data: "dummy image")
    post4.save

    random_fact1 = Fact.random_fact
    expect { Fact.find(random_fact1.id) }.not_to raise_error
    random_fact2 = Fact.random_fact
    expect { Fact.find(random_fact2.id) }.not_to raise_error
    random_fact3 = Fact.random_fact
    expect { Fact.find(random_fact3.id) }.not_to raise_error
    random_fact4 = Fact.random_fact
    expect { Fact.find(random_fact4.id) }.not_to raise_error
  end

  it "should find the top 10 facts in descending order" do
    fact1 = Fact.create(fact:"Chuck Norris 1", image_data:"dummy_image")
    fact2 = Fact.create(fact:"Chuck Norris 2", image_data:"dummy_image")
    fact3 = Fact.create(fact:"Chuck Norris 3", image_data:"dummy_image")
    fact4 = Fact.create(fact:"Chuck Norris 4", image_data:"dummy_image")
    fact5 = Fact.create(fact:"Chuck Norris 5", image_data:"dummy_image")
    fact6 = Fact.create(fact:"Chuck Norris 6", image_data:"dummy_image")
    fact7 = Fact.create(fact:"Chuck Norris 7", image_data:"dummy_image")
    fact8 = Fact.create(fact:"Chuck Norris 8", image_data:"dummy_image")
    fact9 = Fact.create(fact:"Chuck Norris 9", image_data:"dummy_image")
    fact10 = Fact.create(fact:"Chuck Norris 10", image_data:"dummy_image")

    Vote.create(fact: fact5)
    Vote.create(fact: fact5)
    Vote.create(fact: fact5)
    Vote.create(fact: fact5)
    Vote.create(fact: fact2)
    Vote.create(fact: fact2)
    Vote.create(fact: fact2)
    Vote.create(fact: fact1)
    Vote.create(fact: fact7)
    Vote.create(fact: fact7)
    Vote.create(fact: fact6)
    Vote.create(fact: fact4)
    Vote.create(fact: fact3)
    Vote.create(fact: fact7)
    Vote.create(fact: fact3)
    Vote.create(fact: fact9)
    Vote.create(fact: fact7)
    expect(Fact.top10.ids).to eq([5, 7, 2, 3, 1, 4, 6, 9])
    
    5.times {
      Vote.create(fact: fact4)
    }
    expect(Fact.top10.ids).to eq([4, 5, 7, 2, 3, 1, 6, 9])

    10.times {
      Vote.create(fact: fact8)
    }
    expect(Fact.top10.ids).to eq([8, 4, 5, 7, 2, 3, 1, 6, 9])
  end
end
