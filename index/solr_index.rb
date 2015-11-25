#!/usr/bin/ruby

require 'yaml'
require 'mysql2'
require 'rsolr'

db = Mysql2::Client.new YAML.load(File.open '../config/database.yml', 'r')
solr = RSolr.connect(:url => 'http://localhost:8983/solr/torrents')

i = 0
db.query('select * from torrents').each do |row|
  solr.add row
  print (i / 1024).to_s + "k\t\t\r" if i % 1000 == 0
  i += 1
end
