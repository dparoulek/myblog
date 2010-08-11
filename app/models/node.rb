class Node < ActiveRecord::Base

  def to_html
    #TODO: This is really messy, I'll clean this up later
    # Find the file name and contents
    repo = GitRepo.find(git_repo_id)
    fname = repo.getFileName(git_repo_path)
    fcontents = repo.getFileContents(git_repo_path)

    case extension(fname)
    when /mkdwn/i 
      return RDiscount.new(fcontents).to_html
    when /org/i
      return Orgmode::Parser.new(fcontents).to_html
    else
      fcontents
    end
  end

  #TODO: These methods will eventually be moved to an authentication
  #gem. And they need quite a lot of work
  
  # acl is a integer that represents world, group, owner
  # permissions. For example 755
  def chmod(acl)
    if(acl == 777)
      mode = "777"
    end
  end

  def readable?(user)
  end

  def writeable?(user)
  end

  def executable?(user)
  end

  private 
  def extension(filename)
    File.extname(filename)
  end

end



# == Schema Information
#
# Table name: nodes
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  git_repo_id   :string(255)
#  git_repo_path :string(255)
#

