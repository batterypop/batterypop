require 'spec_helper'

describe "episodes/index" do
  before(:each) do
    assign(:episodes, [
      stub_model(Episode,
        :title => "Title",
        :description => "MyText",
        :approved => false,
        :creator_id => 1,
        :show_id => 2,
        :video_type => 3,
        :video_id => "Video"
      ),
      stub_model(Episode,
        :title => "Title",
        :description => "MyText",
        :approved => false,
        :creator_id => 1,
        :show_id => 2,
        :video_type => 3,
        :video_id => "Video"
      )
    ])
  end

  it "renders a list of episodes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Video".to_s, :count => 2
  end
end
