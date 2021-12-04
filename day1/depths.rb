rows = File.read('depths.txt').split.map(&:to_i)
same = 0
incr = 0
decr = 0
last = nil
rows.each do |depth|
  unless last.nil?
    same += 1 if last == depth
    incr += 1 if last < depth
    decr += 1 if last > depth
  end
  last = depth
end

puts "rows =  #{ rows.count }"
puts "total = #{ same + incr + decr }"
puts "same =  #{ same }"
puts "incr =  #{ incr }"
puts "decr =  #{ decr }"
