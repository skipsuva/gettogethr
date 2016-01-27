require 'rails_helper'

RSpec.describe "gatherings/new", type: :view do
  before(:each) do
    assign(:gathering, Gathering.new(
      :title => "MyString",
      :references => ""
    ))
  end

  it "renders new gathering form" do
    render

    assert_select "form[action=?][method=?]", gatherings_path, "post" do

      assert_select "input#gathering_title[name=?]", "gathering[title]"

      assert_select "input#gathering_references[name=?]", "gathering[references]"
    end
  end
end
