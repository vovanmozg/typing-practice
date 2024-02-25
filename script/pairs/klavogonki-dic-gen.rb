output_dir = File.join(File.expand_path('..', File.expand_path('..', __dir__)), 'dictionary', 'pairs')

symbols = %{!1{2}3&4-5%6<7>8(9)0_^=+[@]#*|:;'",\\.|/?}

File.write "#{output_dir}/pairs.txt", symbols
  .split('')
  .permutation(2)
  .to_a
  .map{|a, b| "#{a}#{b}"}
  .join(' ')


File.write "#{output_dir}/pairs-phrases.txt", symbols
                               .split('')
                               .permutation(2)
                               .to_a
                               .map{|a, b| "#{a}#{b} " * 20}
                               .join("\n")

