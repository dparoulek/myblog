require 'spec_helper'

describe "/people/index.html.erb" do
  include PeopleHelper

  before(:each) do
    assigns[:people] = [
      stub_model(Person,
        :email => "value for email",
        :password => "value for password"
      ),
      stub_model(Person,
        :email => "value for email",
        :password => "value for password"
      )
    ]
  end

  it "renders a list of people" do
    render
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for password".to_s, 2)
  end
end
