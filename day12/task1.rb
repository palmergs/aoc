input = File.read('input.txt').split(/[\n\r]/)
map = Hash.new {|h,k| h[k] = [] }
input.each do |path|
  lhs, rhs = path.split('-')
  map[lhs] << rhs unless rhs == 'start' || lhs == 'end'
  map[rhs] << lhs unless rhs == 'end' || lhs == 'start'
end
pp map

require 'set'

def visit map, curr, paths, path = []
  path << curr
  puts "PATH = #{ path.inspect }"
  if curr == 'end'
    puts "END"
    paths << path
    return
  end

  options = map[curr]
  puts "OPTIONS: #{ curr } => #{ options.inspect }"
  options.each do |option|
    if option != option.downcase || !path.include?(option)
      visit(map, option, paths, path.clone)
    end
  end
end

paths = []
visit(map, 'start', paths)
puts "PATHS = #{ paths.inspect }"
puts "PATHS = #{ paths.count }"
