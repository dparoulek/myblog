class Node < ActiveRecord::Base

  def to_html
    case extension
    when /mkdwn/i 
      return RDiscount.new(contents).to_html
    when /org/i
      return Orgmode::Parser.new(contents).to_html
    else
      contents
    end
  end

  def extension
    File.extname(name)
  end

end

# == Schema Information
#
# Table name: nodes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  path       :string(255)
#  contents   :text
#  created_at :datetime
#  updated_at :datetime
#

