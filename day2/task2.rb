movement = File.read('movement.txt').split(/[\n\r]/)
forward = 0
depth = 0
aim = 0
movement.each do |line|
  cmd, num = line.split
  case cmd
  when 'forward'
    forward += num.to_i
    depth += aim * num.to_i
  when 'up'
    aim -= num.to_i
  when 'down'
    aim += num.to_i
  else
    raise line
  end
end

puts "lines = #{ movement.length }"
puts "depth = #{ depth }"
puts "forwd = #{ forward }"
puts "times = #{ depth * forward }"
