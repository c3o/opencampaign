require File.dirname(__FILE__)+"/../../config/environment.rb"

%w(constituencies towns).each do |t|
  puts "Loading #{t}..."
  ActiveRecord::Base.connection.execute("DELETE from #{t}")
  lines = File.readlines(File.dirname(__FILE__)+"/#{t}.sql").map {|l| l.chomp}
  lines.each {|l| ActiveRecord::Base.connection.execute(l) }
end
