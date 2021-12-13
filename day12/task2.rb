input = File.read('input.txt').split(/[\n\r]/)
map = Hash.new {|h,k| h[k] = [] }
input.each do |path|
  lhs, rhs = path.split('-')
  map[lhs] << rhs unless rhs == 'start' || lhs == 'end'
  map[rhs] << lhs unless rhs == 'end' || lhs == 'start'
end
pp map

require 'set'

def can_visit option, path
  return true if option != option.downcase
  return true unless path.include?(option)

  lowercase = path.select {|cave| cave.downcase == cave}.sort
  (1...lowercase.length).each do |n|
    return false if lowercase[n-1] == lowercase[n]
  end

  true
end

def visit map, curr, paths, path = []
  path << curr
  puts "PATH = #{ path.inspect }"
  if curr == 'end'
    puts "END"
    paths << path
    return
  end

  options = map[curr]
  options.each do |option|
    if can_visit(option, path)
      visit(map, option, paths, path.clone)
    end
  end
end

paths = []
visit(map, 'start', paths)
puts "PATHS = #{ paths.count }"
