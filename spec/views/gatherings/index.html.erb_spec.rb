require 'rails_helper'

RSpec.describe "gatherings/index", type: :view do
  before(:each) do
    assign(:gatherings, [
      Gathering.create!(
        :title => "Title",
        :owner => nil
      ),
      Gathering.create!(
        :title => "Title",
        :owner => nil
      )
    ])
  end

  it "renders a list of gatherings" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
