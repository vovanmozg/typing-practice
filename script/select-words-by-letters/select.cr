#1234567890
#!;:?()
#.,юбъбхжэ"
#$^

require "json"

result = Array(String).new

File.read("./russian.dic").split("\n").each do |word|
  matches = word.scan(/[юбъх]/)
  
  
  if matches.size > 1 && word.size < 20
    result << "#{matches.size} #{word.size} #{word}"
  end
end

result.sort! { |a, b| b <=> a }
File.write("./words.txt", result.join("\n"))



# File.each_line("./russian.dic", "r") do |line|
#   words << line  
# end



