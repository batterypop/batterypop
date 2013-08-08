require 'spec_helper'

describe "shows/edit" do
  before(:each) do
    @show = assign(:show, stub_model(Show,
      :title => "MyString",
      :description => "MyText",
      :approved => false
    ))
  end

  it "renders the edit show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", show_path(@show), "post" do
      assert_select "input#show_title[name=?]", "show[title]"
      assert_select "textarea#show_description[name=?]", "show[description]"
      assert_select "input#show_approved[name=?]", "show[approved]"
    end
  end
end
