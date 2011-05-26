# $_
# $. == $<.lineno
# $F fields
ruby --help

# -O15 == carriage return \r is 015; man ascii;

ruby -e 'puts "hello, world!"'
ruby -pe '$_ = "#" + $_' some_file.rb
ruby -i.bak -pe '$_ = "#" + $_' *.rb
ruby -a -F, -i -ne 'puts $F.values_at(1,2,3).join("\t")' some_file.rb

ruby -e 'puts Dir["*.rb"].find{|f| File.size(f) < 2048}.sort_by{|f| File.mtime(f)}'

ruby -e 'system "clear; ls -lahG" while sleep 1'  #watch

ruby -rFileutils -e 'f = ARGV[0]; FileUtils.mv(f, f + Time.now.strftime(".%y%m%dT%H%M%S") if File.exists?(f) and File.size(f) > 1024' /path/to/file.log

