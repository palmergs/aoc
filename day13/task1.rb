input = File.read('input.txt')
coords, folds = input.split(/^$/)
coords = coords.split(/[\n\r]/).map {|line| line.split(',').map(&:to_i) }
folds = folds.strip.split(/[\n\r]/).map do |line|
  dim, val = line.split('=')
  [ dim, val.to_i ]
end

class Sensor
  attr_reader :coords, :folds, :array

  def initialize coords, folds
    @coords = coords
    @folds = folds

    maxx = 0
    maxy = 0
    @coords.each do |coord|
      maxx = [maxx, coord[0]].max
      maxy = [maxy, coord[1]].max
    end
    @array = Array.new(maxy) { Array.new(maxx) }
  end

  def width
    @array[0].size
  end

  def height
    @array.size
  end

  def fold num = nil

  end

  def self.print coords

  end
end
