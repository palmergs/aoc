rows = File.read('depths.txt').split.map(&:to_i)
same = 0
incr = 0
decr = 0
last = nil
(0...rows.length).each do |idx|
  next if idx < 2

  curr = rows[idx - 2] + rows[idx - 1] + rows[idx]
  unless last.nil?
    same += 1 if last == curr
    incr += 1 if last < curr
    decr += 1 if last > curr
  end
  last = curr
end

puts "rows =  #{ rows.count } (#{ rows.count / 3 } #{ rows.count % 3 })"
puts "total = #{ same + incr + decr }"
puts "same =  #{ same }"
puts "incr =  #{ incr }"
puts "decr =  #{ decr }"
