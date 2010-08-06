require 'spec_helper'

describe "/people/new.html.erb" do
  include PeopleHelper

  before(:each) do
    assigns[:person] = stub_model(Person,
      :new_record? => true,
      :email => "value for email",
      :password => "value for password"
    )
  end

  it "renders new person form" do
    render

    response.should have_tag("form[action=?][method=post]", people_path) do
      with_tag("input#person_email[name=?]", "person[email]")
      with_tag("input#person_password[name=?]", "person[password]")
    end
  end
end
