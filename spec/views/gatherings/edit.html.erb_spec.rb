require 'rails_helper'

RSpec.describe "gatherings/edit", type: :view do
  before(:each) do
    @gathering = assign(:gathering, Gathering.create!(
      :title => "MyString",
      :references => ""
    ))
  end

  it "renders the edit gathering form" do
    render

    assert_select "form[action=?][method=?]", gathering_path(@gathering), "post" do

      assert_select "input#gathering_title[name=?]", "gathering[title]"

      assert_select "input#gathering_references[name=?]", "gathering[references]"
    end
  end
end
