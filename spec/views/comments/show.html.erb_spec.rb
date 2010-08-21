require 'spec_helper'

describe "/comments/show.html.erb" do
  include CommentsHelper
  before(:each) do
    assigns[:comment] = @comment = stub_model(Comment,
      :username => "value for username",
      :comment => "value for comment",
      :parent_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ username/)
    response.should have_text(/value\ for\ comment/)
    response.should have_text(/1/)
  end
end
