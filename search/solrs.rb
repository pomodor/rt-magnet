#!/usr/bin/ruby

require 'rsolr'

MAGNET_PREFIX = 'magnet:?xt=urn:btih:'

if ARGV.length == 0
  puts './rsols запрос'
  exit false
end

solr = RSolr.connect url: 'http://localhost:8983/solr/torrents'

res = solr.get 'select', params: { q: ARGV.join(' ') }
res['response']['docs'].each do |r|
  puts r['name']
  puts MAGNET_PREFIX + r['magnet'].to_s
  puts
end
