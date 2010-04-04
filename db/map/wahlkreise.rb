require 'rubygems'
require 'json'
require 'rexml/document'
require 'gmap_polyline_encoder'
include REXML

class P
  attr_accessor :lat, :lng
  def initialize(lat, lng)
    @lat, @lng = lat, lng
  end
end

output = []
doc = Document.new File.new('wahlkreise.kml')
encoder = GMapPolylineEncoder.new()
doc.elements.each("kml/Document/Folder/Placemark") do |p|
  name, wkid = p.elements['name'].text.match(/(.*)\((.*)\)/).captures
  entry = {:name => name, :id => wkid}
  cs = []
  coords = p.elements["Polygon/*/*/coordinates"].text
  coords.split(/\s/).each do |c|
    lat,long,alt = c.split(',')
    cs << [long.to_f, lat.to_f] if long && lat
  end
  entry[:polyline] = encoder.encode(cs)
  output << entry  
end
puts 'var constituencies = '
puts JSON.generate(output)
