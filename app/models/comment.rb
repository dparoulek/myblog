class Comment < ActiveRecord::Base
  belongs_to :node
  validates_presence_of :username, :comment
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
#

