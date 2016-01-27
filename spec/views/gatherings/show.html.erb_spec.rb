require 'rails_helper'

RSpec.describe "gatherings/show", type: :view do
  before(:each) do
    @gathering = assign(:gathering, Gathering.create!(
      :title => "Title",
      :owner => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
