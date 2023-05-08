require "XML"
require "http/client"

class RSSFeedSource
  property uri : URI
  property data : XML?

  def initialize(@uri)
  end

  def read : RSSFeed
    tmp = HTTP::Client.get(uri) do |response|
      if response.status_code == 200
        body = response.body_io.gets_to_end
        data = XML.parse body
        p! data
      end
    end
  end
end

class RSSFeed
  # Required elements
  property title : String
  property link : String # TODO: Maybe a URI?
  property description : String

  # Optional elements
  property language : String? # e.g. 'en-us'
  property copyright : String?
  property managingEditor : String?
  property webmaster : String?
  property pubDate : String? # TODO: For now, but maybe a date
  property lastBuildDate : String?
  property category : String?
  property generator : String?
  property docs : String?
  property cloud : String?
  property ttl : Int32?
  property image : String? # TODO: For now
  property rating : String?
  property textInput : Nil
  property skipHours : String?
  property skipDays : String?

  def initialize(@title, @link, @description)
  end

  # Read in stuffs
  def self.new(xml : XML)
    xml
  end
end
