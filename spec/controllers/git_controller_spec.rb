require 'spec_helper'

describe GitController do
  fixtures :git_repos

  it "should list folders and files from root of git repository" do
    notes_repo = git_repos(:notes)
    notes_repo.path.should == "/Users/dparoulek/notes"
    post :ls, :id => 1
    assigns[:listing].length.should >= 0 
  end

end
