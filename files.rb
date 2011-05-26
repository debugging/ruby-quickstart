File.open("/path/to/file", w) do |f|
  f.flock(File::LOCK_EX)
  #...
  f.flock(File::LOCK_UN)
end

File.open("/path/to/file", w) do |f|
  if f.flock(File::LOCK_EX | File::LOCK_NB)
    #...
    f.flock(File::LOCK_UN)
  else warn "couldn't lock"
  end
end

require "fileutils"
require "tempfile"

class File
  def File.open_using_temp(path)
    res, tmp_path = nil, nil
    Tempfile.open("....") do |f|
      result = yeild f
      tmp_path = f.path
    end
    FileUtils.move(tmp_path, path)
    res
  end
end

Dir["*.[c|h]"].each do ...
Dir["**/**"].each do ...

lines = IO.readlines(path)
lines.each_with_index do |line, i|
end

