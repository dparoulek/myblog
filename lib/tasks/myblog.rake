require File.expand_path(File.dirname(__FILE__) + "/../bloodhound/bloodhound")
require File.expand_path(File.dirname(__FILE__) + "/../drupal/import_comments")
include BloodHound
include DrupalHelpers

namespace :myblog do 
  desc 'Rebuilds Ferret search index inside tmp/searchindex/RAILS_ENV'
  task :reindex => :environment do 
    GitRepo.find(:all).each do |repo|
      puts "Reindexing #{repo.path} ..."
      reindex(repo.path, {:id => repo.id, :git_repo_path => repo.path, :git_repo_name => repo.name})
    end
  end

  desc 'import comments from drupal comment table export'
  task :import_drupal_comments => :environment do 
    nodes = Node.find(:all).map { |node| "(id:#{node.id}) - #{node.name}" }
    node_map = Hash.new
    drupal_comments = import_comments_from_xml_file('lib/drupal/drupal_comments.xml')
    puts "Processing #{drupal_comments.size} comments from drupal"
    drupal_comments.each { |comment|
      drupal_id = comment[:node_id]
      rails_node_id = node_map[drupal_id]
      if(!rails_node_id)
        rails_node_id = ask("Please choose Node ID to associate with Drupal Node:'#{drupal_id}'\n#{nodes.join("\r\n")}\r\n:Node ID> ")
      end
      node_map[drupal_id]=rails_node_id
      comment[:node_id]=rails_node_id
      rails_comment = Comment.new(comment)
      rails_comment.save!
    }
  end

  def ask message
    print message
    STDIN.gets.chomp
  end

end
