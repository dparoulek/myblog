class Person < ActiveRecord::Base

  # A valid Person object is returned if authenticated. Otherwise, return nil
  def self.authenticate_by_password(email, password)
    lookup = find_by_email(email)
    if (lookup)
      if(lookup.password == password)
        return lookup
      end
    end
  end

  # Return logged in person object. Otherwise return nil
  def self.loggedin?()
    return session[:person]
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

