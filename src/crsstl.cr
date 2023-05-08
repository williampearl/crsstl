require "http/client"
require "option_parser"
require "./rssfeed"

feed_list_file = File::NULL
OptionParser.parse do |parser|
  parser.banner = "crsstl RSS feed reader by Will Pearl"
  parser.on "-v", "--v", "Show Version" do
    puts "TODO"
    exit
  end
  parser.on "-h", "--help", "Help" do
    puts parser
    exit
  end
  parser.on "-i FEED_FILE", "--input FEED_FILE", "Input File" do |file_name|
    if !File.exists?(file_name)
      puts "Could not find file #{file_name}"
      exit
    end
    feed_list_file = File.new file_name
  end
  parser.invalid_option { |flag|
    STDERR.puts "Could not find option \"#{flag}\"."
    exit
  }
end

if feed_list_file == File::NULL
  puts "Somehow did not get file"
  exit
end

# Read input file
urls = [] of URI
feed_list_file.each_line { |line| urls << URI.parse line.chomp }

# Create RSS feeds
rss_feeds = [] of RSSFeedSource
urls.each do |uri|
  rss_feeds << RSSFeedSource.new uri
end

rss_feeds.each { |f| f.read }
