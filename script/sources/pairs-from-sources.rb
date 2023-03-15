require 'pry'


files = Dir.glob('/tmp/code/**/*.rb')
puts("found #{files.size} files")

pairs = Hash.new(0)

files.map do |file|
  next if File.directory?(file)

  content = File.read(file).gsub("\n", '')
  i = content.length - 2
  while i >= 0
    pair = content[i..i+1]
    if pair =~ %r{[!1{2}3&4-5%6<7>8(9)0_^=+\[@\]#*|:;'",\\.\|/?]}
      pairs[pair] += 1
    end
    i -= 1
  end
end

sorted = pairs.sort_by { |_key, value| -value }.to_h.keys

output_dir = File.join(File.expand_path('..', File.expand_path('..', __dir__)), 'dictionary', 'sources')
File.write("#{output_dir}/pairs-from-sources.txt", sorted.join("\n"))
