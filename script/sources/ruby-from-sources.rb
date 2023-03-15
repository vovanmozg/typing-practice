require 'pry'
require './code_finder'

dir = '/tmp/code'

CodeFinder.new('Ruby').run(dir, 'gems') do |checker, str|
  checker.code?(str) &&
    !checker.has_non_ascii?(str) &&
    !checker.a_lot_of_letters?(str) &&
    !checker.a_lot_of_caps?(str) &&
    !checker.a_lot_of_digits?(str) &&
    !checker.multispaces?(str) &&
    !checker.a_lot_of_special?(str)
  #   checker.long_completed_line?(str) &&
  #   !checker.a_lot_of_letters?(str) &&

end

# remove square brackets
# cat gems.txt | grep -v "\[" | grep -v "\]" > gems-pub.txt