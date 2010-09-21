require 'spec_helper'

describe Comment do
  before(:each) do
    @valid_attributes = {
      :username => "value for username",
      :comment => "value for comment",
      :parent_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
end


# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  comment    :text
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  node_id    :integer
#  email      :string(255)
#  homepage   :string(255)
#  subject    :string(255)
#  hostname   :string(255)
#

