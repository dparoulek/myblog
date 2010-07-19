# Represents a git repository. For now, the name can't contain spaces
# to keep things simple
class GitRepo < ActiveRecord::Base
  validates_presence_of :name, :path
  validates_format_of :name, :with => /\S+/
  
  def before_validation
    self.path = File.expand_path(self.path)
  end

end


# == Schema Information
#
# Table name: git_repos
#
#  id         :integer         not null, primary key
#  path       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

