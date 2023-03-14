require 'pry'
require './code_finder'

dir = ARGV[0]


CodeFinder.new('TypeScript').run(dir, 'nextjs2') do |checker, str|
  checker.code?(str)
  # checker.code?(str) &&
  #   checker.long_completed_line?(str) &&
  #   !checker.a_lot_of_letters?(str) &&
  #   !checker.has_non_ascii?(str)
end