symbols = %{!1{2}3&4-5%6<7>8(9)0_^=+[@]#*|:;'",\\.|/?}
File.write 'klavogonki.txt', symbols
  .split('')
  .permutation(2)
  .to_a
  .map{|a, b| "#{a}#{b}"}
  .join(' ')

