require 'rails_helper'

RSpec.describe "gatherings/new", type: :view do
  before(:each) do
    assign(:gathering, Gathering.new(
      :title => "MyString",
      :owner => nil
    ))
  end

  it "renders new gathering form" do
    render

    assert_select "form[action=?][method=?]", gatherings_path, "post" do

      assert_select "input#gathering_title[name=?]", "gathering[title]"

      assert_select "input#gathering_owner_id[name=?]", "gathering[owner_id]"
    end
  end
end
