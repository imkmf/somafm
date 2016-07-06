require 'mechanize'
agent = Mechanize.new

BASE = "http://somafm.com/"

def stream_url_from_program_link(link)
  cleaned = link.to_s.gsub('/','')
  "#{BASE}#{cleaned}.pls"
end

page = agent.get(BASE)
programs = page.css("#stations a")
streams = programs.map { |p| stream_url_from_program_link(p.attribute("href")) }

streams.each do |stream|
  puts "Downloading #{stream}"
  `wget "#{stream}"`
end
