#!/usr/bin/ruby

require 'CSV'
require 'yaml'
require 'mysql2'

if ARGV.length == 1
  csv_import_dir = ARGV[0]
else
  puts 'import.rb <директория с файлами csv>'
  exit false
end

db = Mysql2::Client.new YAML.load(File.open 'database.yml', 'r')

puts 'Импортируем из директории ' + csv_import_dir + ' в базу данных ' +
  db.query_options[:database] + '@' + db.query_options[:host]

Dir.entries(csv_import_dir).each do |dir_items|
  next unless /^\d{8}$/ =~ dir_items
  Dir.entries([csv_import_dir, dir_items].join('/')).each do |file|
    next unless /^category_\d+.csv$/ =~ file
    file = [csv_import_dir, dir_items, file].join('/')
    lines_count = 0
    
    CSV.parse File.open(file, 'r').read, col_sep: ';' do |row|
      begin
        db.prepare('insert ignore into torrents set name = ?, magnet = ?').execute(row[4], row[3])
        lines_count += 1
      rescue Exception => e
        puts e.message
        exit false
      end
      print file + ': ' + (lines_count / 1000).to_s + "k \r" if lines_count % 100 == 0
    end

    puts
  end
end
