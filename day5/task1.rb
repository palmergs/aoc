lines = File.read('input.txt').split(/[\n\r]/)
map = Hash.new {|h, k| h[k] = 0 }
horiz = 0
vert = 0
diag = 0
tot = 0
lines.each do |line|
  pair = line.split(' -> ')
  x1, y1 = pair[0].split(',').map(&:to_i)
  x2, y2 = pair[1].split(',').map(&:to_i)
  if x1 == x2
    miny = y1 < y2 ? y1 : y2
    maxy = y1 < y2 ? y2 : y1
    (miny..maxy).each do |n|
      tot += 1
      map[[x1, n]] += 1
      puts "overlap #{ line } at #{ x1 },#{ n } #{ map[[x1, n]] }" if map[[x1, n]] > 1
    end
    horiz += 1
    puts "horizontal #{ line } (#{ x1 },#{ y1 } -> #{ x2 },#{ y2 })"
  elsif y1 == y2
    minx = x1 < x2 ? x1 : x2
    maxx = x1 < x2 ? x2 : x1
    (minx..maxx).each do |n|
      tot += 1
      map[[n, y1]] += 1
      puts "overlap #{ line } at #{ n },#{ y1 } #{ map[[n, y1]] }" if map[[n, y1]] > 1
    end
    vert += 1
    puts "vertical #{ line } (#{ x1 },#{ y1 } -> #{ x2 },#{ y2 })"
  else
    diag += 1
    puts "skipping #{ line } (#{ x1 },#{ y1 } -> #{ x2 },#{ y2 })"
  end
end

cnt = 0
map.each do |k, v|
  cnt += 1 if v > 1
end

puts "lines=#{ lines.length } (horiz: #{ horiz }, vert: #{ vert }, diag: #{ diag })"
puts "points=#{ map.size }"
puts "total=#{ tot }"
puts "overlap=#{ cnt }"
