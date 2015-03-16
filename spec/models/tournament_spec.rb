require 'spec_helper'

describe Tournament do
  it "creates a tournament and matches from given episodes" do
    eps = Episode.all[0,4]
    tmt = Tournament.with_episodes eps, title: "test_tournament"
    tmt.episodes.count.should == 4
    tmt.matches.count.should == 2
    tmt.destroy
  end
end
