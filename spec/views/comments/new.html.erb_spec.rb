require 'spec_helper'

describe "/comments/new.html.erb" do
  include CommentsHelper

  before(:each) do
    assigns[:comment] = stub_model(Comment,
      :new_record? => true,
      :username => "value for username",
      :comment => "value for comment",
      :parent_id => 1
    )
  end

  it "renders new comment form" do
    render

    response.should have_tag("form[action=?][method=post]", comments_path) do
      with_tag("input#comment_username[name=?]", "comment[username]")
      with_tag("textarea#comment_comment[name=?]", "comment[comment]")
      with_tag("input#comment_parent_id[name=?]", "comment[parent_id]")
    end
  end
end
