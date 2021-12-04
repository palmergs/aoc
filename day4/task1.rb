input = File.read('input.txt').split(/[\n\r]/)
numbers = input[0].split(',')

class Board
  Square = Struct.new(:num, :match) do
    def to_s
      "#{ num }#{ match ? '*' : '' }"
    end
  end

  attr_reader :index, :board, :last

  def initialize index, input
    @index = index / 6
    @board = []
    @last = nil
    (0..4).each do |n| 
      row = input[index + n].strip.split(/\s+/).compact.map {|n| Square.new(n.to_i, false) }
      @board += row
    end
  end

  def match? n
    @last = n.to_i
    @board.each do |sq|
      if sq.num == @last
        sq.match = true
        return true
      end
    end

    false
  end

  def unmatched
    board.select {|sq| sq.match == false}.map {|sq| sq.num }
  end

  def score
    unmatched.inject(&:+) * last
  end

  def win?
    (0..4).each do |r|
      return true if row?(r)
    end

    (0..4).each do |c|
      return true if col?(c)
    end

    false
  end

  def row? r
    (0..4).each do |c|
      return false if board[Board.from_rc(r, c)].match == false
    end

    true
  end

  def col? c
    (0..4).each do |r|
      return false if board[Board.from_rc(r, c)].match == false
    end

    true
  end

  def to_s
    "#{ index }: #{ board.join(', ') }"
  end

  def self.from_xy x, y
    y * 5 + x
  end

  def self.from_rc row, col
    row * 5 + col
  end

  def self.to_xy idx
    [idx % 5, idx / 5]
  end
end

boards = []
index = 2
while index < input.length
  boards << Board.new(index, input)
  index += 6
end

winning = []
numbers.each do |n|
  puts "calling #{ n }"
  boards.each do |board|
    next if board.win?

    if board.match?(n)
      puts "match: #{ board }"
      if board.win?
        winning << board
      end
    end
  end
end

winning.each_with_index do |board, idx|
  puts "#{ idx }. #{ board } last=#{ board.last } score=#{ board.score }"
end

