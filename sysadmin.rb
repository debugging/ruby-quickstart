# $_
# $. == $<.lineno
# $F fields
ruby --help
ruby -e 'puts "hello, world!"'
ruby -pe '$_ = "#" + $_' some_file.rb
ruby -i.bak -pe '$_ = "#" + $_' *.rb
ruby -a -F, -i -ne 'puts $F.values_at(1,2,3).join("\t")' some_file.rb

