LONG_LINE_LEN = 80
def run
  dir = ARGV[0]
  raise 'Specify directory' unless ARGV[0]

  selector = proc do |str|
    code?(str) &&
      long_completed_line?(str) &&
      !a_lot_of_letters?(str) &&
      !has_non_ascii?(str)
  end

  pattern = "#{dir}/**/*.ts"
  files = Dir.glob(pattern)
  log("found #{files.size} files in #{pattern}")

  selected = files.map do |file|
    lines = File.readlines(file).map(&:chop).map(&:strip)
    lines.select(&selector)
  end.compact.flatten.uniq

  output_dir = File.join(File.expand_path('..', File.expand_path('..', __dir__)), 'dictionary', 'long-js')
  output_file = File.join(output_dir, 'nextjs.txt')
  File.write(output_file, selected.join("\n"))
end

def code?(str)
  str[0] != '/' && str[0] != '*' && str[0] != '`' && str[0] != "'" && str[0] != '"'
end

def long_completed_line?(str)
  str.size > LONG_LINE_LEN
end

def a_lot_of_letters?(str)
  str.scan(/[a-zA-Z0-9]/).size > str.size * 0.8
end

def has_non_ascii?(str)
  str =~ /[^\x00-\x7F]+/
end

def log(str)
  puts(str)
end

run