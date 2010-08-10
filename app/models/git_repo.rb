# Represents a git repository. For now, the name can't contain spaces
# to keep things simple
class GitRepo < ActiveRecord::Base
  include Grit

  validates_presence_of :name, :path
  validates_format_of :name, :with => /\S+/
  
  def before_validation
    self.path = File.expand_path(self.path)
  end

  def repo
    @repo ||= Repo.new(self.path)
  end

  def is_a_directory?(path)
    grit_obj = open(path)
    grit_obj.is_a?(Grit::Tree)
  end

  def is_a_file?(path)
    grit_obj = open(path)
    grit_obj.is_a?(Grit::Blob)
  end

  def getDirectory(path)
    throw "#{path} is not a directory" unless(is_a_directory?(path))
    open(path)
  end

  def getFile(path)
    throw "#{path} is not a file" unless(is_a_file?(path))
    open(path)
  end

  def open(path=nil)
    if(path)
      return repo.tree/path
    else
      return repo.tree
    end
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

