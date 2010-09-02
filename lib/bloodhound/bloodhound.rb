require 'rubygems'
require 'ferret'
require 'fileutils'
include Ferret
include Ferret::Index

module BloodHound
  def search_index_dir
    $index_dir ||= File.expand_path(File.dirname(__FILE__) + "/../../tmp/searchindex")
  end

  def reindex(data_dir, index_dir=search_index_dir)
    begin
      FileUtils.mkdir_p(index_dir)
    rescue => e
      puts("Unable to create #{index_dir}")
      puts("#{e.class} => #{e.message}")
      return false
    end

    index = Index.new(:path => index_dir, :create => true)
    Dir["#{data_dir}/**/*.{mkdwn,txt,org}"].each do |file_name|
      index << {:file_name => file_name, :content => File.read(file_name)}
    end
    
    index.optimize()
    index.close()
    return true
  end

  def search_index(search_phrase, index_dir)
    index = Index.new(:path => index_dir)
    results = []
    total_hits = index.search_each(search_phrase) do |doc_id, score|
      results << "  #{score} - #{index[doc_id][:file_name]}"
    end

    puts "#{total_hits} matched your query:\n" + results.join("\n")
    index.close()
  end

end
