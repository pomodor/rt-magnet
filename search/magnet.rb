#!/usr/bin/ruby

require 'yaml'
require 'mysql2'

MAGNET_PREFIX = 'magnet:?xt=urn:btih:'

if ARGV.length == 0
  puts './magnet.rb <ключ 1> <ключ 2> ... <ключ n>'
  exit false
end

query = "select name, concat('#{MAGNET_PREFIX}', magnet) as link from torrents where name like '%" +
  ARGV.join("%' and name like '%") + "%'"

begin
  db = Mysql2::Client.new YAML.load(File.open '../config/database.yml', 'r')
  result = db.query(query)
rescue Exception => e
  puts e.message
  exit false
end

result.each do |row|
  puts row['name']
  puts row['link']
  puts '=' * 80
end
