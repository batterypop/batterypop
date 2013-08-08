require 'spec_helper'

describe "episodes/edit" do
  before(:each) do
    @episode = assign(:episode, stub_model(Episode,
      :title => "MyString",
      :description => "MyText",
      :approved => false,
      :creator_id => 1,
      :show_id => 1,
      :video_type => 1,
      :video_id => "MyString"
    ))
  end

  it "renders the edit episode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", episode_path(@episode), "post" do
      assert_select "input#episode_title[name=?]", "episode[title]"
      assert_select "textarea#episode_description[name=?]", "episode[description]"
      assert_select "input#episode_approved[name=?]", "episode[approved]"
      assert_select "input#episode_creator_id[name=?]", "episode[creator_id]"
      assert_select "input#episode_show_id[name=?]", "episode[show_id]"
      assert_select "input#episode_video_type[name=?]", "episode[video_type]"
      assert_select "input#episode_video_id[name=?]", "episode[video_id]"
    end
  end
end
