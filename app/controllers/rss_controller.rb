class RssController < ApplicationController
  skip_before_filter :auth_required

  def index
    @nodes = Node.find(:all, :order => "publish_date DESC, id DESC",
                  :conditions => { :public => true }) 
    render :layout => false
  end

end
