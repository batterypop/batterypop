require 'spec_helper'

describe "shows/show" do
  before(:each) do
    @show = assign(:show, stub_model(Show,
      :title => "Title",
      :description => "MyText",
      :approved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
