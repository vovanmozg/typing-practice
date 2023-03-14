require 'pry'

lines = File.readlines('../../dictionary/ru-all-forms/ru_RU.dic')
lines = (lines.grep(/х/) + lines.grep(/б/) + lines.grep(/з/) + lines.grep(/ю/)).uniq

lines = lines
  .sort_by { |word| -word.scan(/[бзюхБЗЮХ]/).size }
  .select { |word| word.scan(/[бзюхБЗЮХ]/).size >= 3 }
  .map { |word| word.chomp.gsub(%r{/[^\s]+},"") }
  .sort_by(&:size)


# p lines.take(10)

lines = File.write('../../dictionary/b-z-kh-yu/b-z-kh-yu.dic', lines.join("\n"))