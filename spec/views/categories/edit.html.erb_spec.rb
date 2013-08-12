require 'spec_helper'

describe "categories/edit" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :title => "MyString",
      :description => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders the edit category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", category_path(@category), "post" do
      assert_select "input#category_title[name=?]", "category[title]"
      assert_select "textarea#category_description[name=?]", "category[description]"
      assert_select "input#category_slug[name=?]", "category[slug]"
    end
  end
end
