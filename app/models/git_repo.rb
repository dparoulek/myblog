class GitRepo < ActiveRecord::Base

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
#

