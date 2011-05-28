def blah
  yield if block_given?
end

blah { puts 'hi' }
blah do
  puts 'hi from do end'
end
