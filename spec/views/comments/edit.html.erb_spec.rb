require 'spec_helper'

describe "/comments/edit.html.erb" do
  include CommentsHelper

  before(:each) do
    assigns[:comment] = @comment = stub_model(Comment,
      :new_record? => false,
      :username => "value for username",
      :comment => "value for comment",
      :parent_id => 1
    )
  end

  it "renders the edit comment form" do
    render

    response.should have_tag("form[action=#{comment_path(@comment)}][method=post]") do
      with_tag('input#comment_username[name=?]', "comment[username]")
      with_tag('textarea#comment_comment[name=?]', "comment[comment]")
      with_tag('input#comment_parent_id[name=?]', "comment[parent_id]")
    end
  end
end
