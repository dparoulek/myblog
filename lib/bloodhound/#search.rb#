require 'bloodhound'
include BloodHound

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <search phrase> <index_dir>"
  exit(1)
end

usage() if ARGV.size !=2
usage("Index '#{ARGV[0]}' doesn't exist.") unless File.directory?(ARGV[1])
search_phrase, index_dir = ARGV

search_index(search_phrase, index_dir)
