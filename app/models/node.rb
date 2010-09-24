class Node < ActiveRecord::Base
  # used to paginate nodes in views
  cattr_accessor :per_page
  @@per_page = 5

  # nodes have comments
  has_many :comments
  
  before_save :default_values
  
  def default_values
    self.publish_date = DateTime.now unless self.publish_date
    self.public = true unless self.public
  end

  def next_node()
    @nodes = Node.find_by_sql(["select * from nodes where public = 'true' AND publish_date >= ? AND id != ? order by publish_date ASC, id ASC", self.publish_date, self.id])
    @nodes[0]
  end

  def previous_node()
    @nodes = Node.find_by_sql(["select * from nodes where public = 'true' AND publish_date <= ? AND id != ? order by publish_date DESC, id DESC", self.publish_date, self.id])
    @nodes[0]
  end

  def self.most_recent_node()
    @nodes = find(:first, :order => "publish_date DESC, id DESC", 
                  :conditions => { :public => true })
  end

  def self.most_recent_nodes(page=1)
    page_num=page.to_i-1
    @nodes = find(:all, :order => "publish_date DESC", 
                        :limit => @@per_page,
                        :offset => page_num*@@per_page,
                        :conditions => { :public => true })
  end

  def self.total_published
    @total_published = find(:all, :conditions => { :public => true }).count
  end

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

  def friendly_path 
    if self.friendly_url
      return "/#{self.friendly_url}"
    else 
      return self
    end
  end

  #TODO: These methods will eventually be moved to an authentication
  #gem. And they need quite a lot of work
  
  # acl is a integer that represents world, group, owner
  # permissions. For example 755
  # TODO: finish implementing
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
#  git_repo_path :string(255)
#  public        :boolean
#  publish_date  :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  git_repo_id   :integer
#  friendly_url  :string(255)
#

