require 'rails_helper'

RSpec.describe "facts/edit", type: :view do
  before(:each) do
    @fact = assign(:fact, Fact.create!(
      :joke => "MyString",
      :votes => 1
    ))
  end

  it "renders the edit fact form" do
    render

    assert_select "form[action=?][method=?]", fact_path(@fact), "post" do

      assert_select "input[name=?]", "fact[joke]"

      assert_select "input[name=?]", "fact[votes]"
    end
  end
end
