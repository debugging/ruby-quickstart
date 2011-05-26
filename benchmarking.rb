# time ruby -e '1000.times { 1 + 1 }
require "benchmark"
require "pp"

Benchmark.bm(5). do |b|
  b.report("abc") { ... }
  b.report("def") { ... }
end

Benchmark.bmbm(5) do |b|
   # b.report("..") do
   # end
end

require "profile"

# or

require "profiler"

Profiler__.start_profile
# ...
Profiler__.stop_profile
Profiler__.print_profile($stdout)

