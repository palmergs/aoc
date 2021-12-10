lines = File.read('input.txt').split(/[\n\r]/)
array = lines.map {|str| str.chars.map(&:to_i) }

class Heights
  attr_reader :array

  def initialize array
    @array = array
  end

  def at x, y
    row = array[y]
    row[x]
  end

  def lowest? x, y
    xmax = array[0].length
    ymax = array.length
    if x == 0
      if y == 0
        at(x,y) < at(x+1,y) && at(x,y) < at(x, y+1)
      elsif y == ymax-1
        at(x,y) < at(x+1,y) && at(x,y) < at(x, y-1)
      else
        at(x,y) < at(x+1,y) && at(x,y) < at(x, y+1) && at(x,y) < at(x, y-1)
      end
    elsif x == xmax-1
      if y == 0
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y+1)
      elsif y == ymax-1
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y-1)
      else
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y+1) && at(x,y) < at(x,y-1)
      end
    else
      if y == 0
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y+1) && at(x,y) < at(x+1,y)
      elsif y == ymax-1
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y-1) && at(x,y) < at(x+1,y)
      else
        at(x,y) < at(x-1,y) && at(x,y) < at(x,y+1) && at(x,y) < at(x,y-1) && at(x,y) < at(x+1,y)
      end
    end
  end

  def lowest
    arr = []
    array.each_with_index do |row, y|
      row.each_with_index do |val, x|
        arr << val + 1 if lowest?(x,y)
      end
    end
    arr
  end

  def sum
    lowest.inject(&:+)
  end
end

h = Heights.new(array)
puts h.lowest
puts "sum=#{ h.sum }"
