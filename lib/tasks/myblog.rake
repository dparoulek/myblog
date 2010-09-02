require File.expand_path(File.dirname(__FILE__) + "/../bloodhound/bloodhound")
include BloodHound
# Tasks for managing search index
namespace :myblog do desc 'Set of tasks for managing the Ferret search index'
  task :reindex => :environment do 
    GitRepo.find(:all).each do |repo|
      puts "Reindexing #{repo.path} ..."
      reindex(repo.path)
    end
  end
end
