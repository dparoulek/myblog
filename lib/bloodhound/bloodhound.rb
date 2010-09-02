require 'rubygems'
require 'ferret'
require 'fileutils'
include Ferret
include Ferret::Index

module BloodHound
  def search_index_dir
    env_dir = RAILS_ENV ? "/#{RAILS_ENV}" : "/development"
    $index_dir ||= File.expand_path(File.dirname(__FILE__) + "/../../tmp/searchindex#{env_dir}")
  end


  # Creates a new Ferret Search Indes for a directory data_dir. Stores
  # the index inside index_dir. Pass a hash of any extra key/value
  # pairs you want to store in the search index. For example, when
  # indexing a git repository, you might pass {:id => 2}
  def reindex(data_dir, fields={}, index_dir=search_index_dir)
    begin
      FileUtils.mkdir_p(index_dir)
    rescue => e
      puts("Unable to create #{index_dir}")
      puts("#{e.class} => #{e.message}")
      return false
    end

    index = Index.new(:path => index_dir, :create => true)
    Dir["#{data_dir}/**/*.{mkdwn,txt,org}"].each do |file_name|
      file_fields = {:abs_file_path => file_name, :content => File.read(file_name)}
      index << fields.merge(file_fields)
    end
    
    index.optimize()
    index.close()
    return true
  end

  # Search for a phrase. Pass array of symbols that you want to
  # include in search results
  def search_index(search_phrase, field_names = [], index_dir=search_index_dir)
    index = Index.new(:path => index_dir)
    results = []
    total_hits = index.search_each(search_phrase) do |doc_id, score|
      fields = {}
      field_names.each do |fieldname|
        fields[fieldname] = index[doc_id][fieldname] 
      end
      results << fields
    end

#     puts "#{total_hits} matched your query:\n" + results.join("\n")
    index.close()
    results
  end

end
