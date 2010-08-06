require 'spec_helper'

describe "/people/edit.html.erb" do
  include PeopleHelper

  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :new_record? => false,
      :email => "value for email",
      :password => "value for password"
    )
  end

  it "renders the edit person form" do
    render

    response.should have_tag("form[action=#{person_path(@person)}][method=post]") do
      with_tag('input#person_email[name=?]', "person[email]")
      with_tag('input#person_password[name=?]', "person[password]")
    end
  end
end
