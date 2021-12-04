entries = File.read('input.txt').split

def scan entries, lamb, pos = 0
  return entries[0] if entries.length == 1

  count = entries.inject(0) do |sum, entry|
    sum += entry[pos] == '1' ? 1 : -1
  end

  comp = lamb.call(count)
  scan(entries.select {|ent| ent[pos] == comp }, lamb, pos + 1)
end

ox = scan(entries, -> (n) { n >= 0 ? '1' : '0' })
oxn = ox.to_i(2)
co = scan(entries, -> (n) { n >= 0 ? '0' : '1' })
con = co.to_i(2)

puts "ox = #{ ox } (#{ oxn })"
puts "co = #{ co } (#{ con })"
puts "lsr = #{ oxn * con }"

