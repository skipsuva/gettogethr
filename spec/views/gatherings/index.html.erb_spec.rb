require 'rails_helper'

RSpec.describe "gatherings/index", type: :view do
  before(:each) do
    assign(:gatherings, [
      Gathering.create!(
        :title => "Title",
        :references => ""
      ),
      Gathering.create!(
        :title => "Title",
        :references => ""
      )
    ])
  end

  it "renders a list of gatherings" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
