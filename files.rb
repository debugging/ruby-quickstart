File.open("/path/to/file", w) do |f|
  f.flock(File::LOCK_EX)
  #...
  f.flock(File::LOCK_UN)
end


