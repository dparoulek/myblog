require 'spec_helper'

describe "/people/show.html.erb" do
  include PeopleHelper
  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :email => "value for email",
      :password => "value for password"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ password/)
  end
end
