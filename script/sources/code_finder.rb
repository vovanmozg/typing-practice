LONG_LINE_LEN = 80

class CodeFinder
  def initialize(lang_id)
    @lang_id = lang_id
  end

  # Example:
  # CodeFinder.new('TypeScript').run(dir, 'nextjs2') do |checker, str|
  #   checker.code?(str) &&
  #     checker.long_completed_line?(str) &&
  #     !checker.a_lot_of_letters?(str) &&
  #     !checker.has_non_ascii?(str)
  # end
  def run(dir, id)
    raise 'Specify directory' unless dir

    selected = traverser(dir).select_lines do |checker, str|
      yield checker, str
    end

    write(selected, id)
  end

  def traverser(dir)
    Object.const_get("CodeFinder::#{@lang_id}Traverser").new(dir)
  end

  def write(selected, id)
    output_dir = File.join(File.expand_path('..', File.expand_path('..', __dir__)), 'dictionary', 'sources')
    output_file = File.join(output_dir, "#{id}.txt")
    File.write(output_file, selected.join("\n"))
  end
end

class CodeFinder::Traverser
  def initialize(dir)
    @dir = dir
  end

  def select_lines(&selector)
    files = Dir.glob(pattern)
    log("found #{files.size} files in #{pattern}")

    files.map do |file|
      lines = File.readlines(file).map(&:chop).map(&:strip)
      ku = lines.select do |str|
        yield checker, str
      end

      ku
    end.compact.flatten.uniq
  end

  private

  def checker
    raise
  end

  def pattern
    raise
  end
end

class CodeFinder::TypeScriptTraverser < CodeFinder::Traverser
  def pattern
    "#{@dir}/**/*.ts"
  end

  def checker
    CodeFinder::TypeScriptChecks
  end
end

class CodeFinder::RubyTraverser < CodeFinder::Traverser
  def pattern
    "#{@dir}/**/*.rb"
  end

  def checker
    CodeFinder::RubyChecks
  end
end

class CodeFinder::Checks
  class << self
    def long_completed_line?(str)
      str.size > LONG_LINE_LEN
    end

    def a_lot_of_letters?(str, multiplier = 0.7)
      str.scan(/[a-zA-Z0-9]/).size > str.size * multiplier
    end

    def a_lot_of_words?(str)
      words = str.scan(/[a-zA-Z0-9]{4,20}/)
      words_average_len = 5
      words.size > str.size / words_average_len / 2
    end

    def has_non_ascii?(str)
      str =~ /[^\x00-\x7F]+/
    rescue
      true
    end

    def a_lot_of_caps?(str, multiplier = 0.2)
      str.scan(/[A-Z]/).size > str.size * multiplier
    end

    def a_lot_of_digits?(str, multiplier = 0.5)
      str.scan(/[0-9]/).size > str.size * multiplier
    end

    def multispaces?(str)
      str =~ /  /
    end

    def a_lot_of_special?(str)
      str.scan(/[^a-zA-Z0-9]/).size > 60
    end

  end
end

class CodeFinder::TypeScriptChecks < CodeFinder::Checks
  class << self
    def code?(str)
      str[0] != '/' && str[0] != '*' && str[0] != '`' && str[0] != "'" && str[0] != '"'
    end
  end
end

class CodeFinder::RubyChecks < CodeFinder::Checks
  class << self
    def code?(str)
      str[0] != '#' && str[0] != '*' && str[0] != '`' && str[0] != "'" && str[0] != '"'
    end
  end
end


def log(str)
  puts(str)
end
