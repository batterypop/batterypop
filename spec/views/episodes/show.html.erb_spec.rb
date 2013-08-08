require 'spec_helper'

describe "episodes/show" do
  before(:each) do
    @episode = assign(:episode, stub_model(Episode,
      :title => "Title",
      :description => "MyText",
      :approved => false,
      :creator_id => 1,
      :show_id => 2,
      :video_type => 3,
      :video_id => "Video"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Video/)
  end
end
