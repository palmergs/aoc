lines = File.read('input.txt').split(/[\n\r]/)

# 0 = 6 lines
# 1 = 2 lines *
# 2 = 5 lines
# 3 = 5 lines
# 4 = 4 lines *
# 5 = 5 lines
# 6 = 6 lines
# 7 = 3 lines *
# 8 = 7 lines *
# 9 = 6 lines

class Entry
  attr_reader :inputs, :outputs
  def initialize line
    @inputs, @outputs = line.split(' | ')
    @inputs = @inputs.split(' ')
    @outputs = @outputs.split(' ')
  end
  
  def to_s
    "#{ inputs.join(' ') } | #{ outputs.join(' ') }"
  end

  def self.length_to_val str
    case str.length
    when 2
      1
    when 4
      4
    when 3
      7
    when 7
      8
    else
      nil
    end
  end
end

entries = lines.map {|line| Entry.new(line) }

values = []
entries.each do |entry|
  arr = entry.outputs.map {|s| Entry.length_to_val(s) }
  puts "#{ entry.outputs.join(' ') } => #{ arr.join(',') }"
  values += arr.compact
end
puts values.join(',')
puts values.count

