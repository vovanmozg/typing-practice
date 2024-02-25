#1234567890
#!;:?()
#.,юбъбхжэ"
#$^ Только русские люди, чтобы избежать штрафа за ложный вызов пожарных, поджигают мебель в прихожей

require "json"

words = Array(String).new

content = File.read("./phrases-sources-1.txt")

words = content.split("\n")


ku = 0
words.each do |word|
  word = word.gsub(/^\d+ */, "")
  matches = word.scan(/[юбъхж]/)
  
  
  if matches.size > 8
    puts word
  end
end



