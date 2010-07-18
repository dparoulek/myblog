require 'spec_helper'

describe Person do
  fixtures :people

  before(:each) do
    @valid_attributes = {
      :email => 'test@gmail.com',
      :password => 'test'
    }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end

  it "should authenticate a user with a valid password" do 
    
    Person.authenticate_by_password('test@email.com', 'test').should == people(:test)
  end

end


# == Schema Information
#
# Table name: people
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  email      :string(255)
#  password   :string(255)
#

