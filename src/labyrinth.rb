class Grid
  attr_reader :width, :height 

  def initialize(width, height)
    @width = width
    @height = height
    @grid = Array.new(height){Array.new(width)} 
  end

  def set(x, y, value)
    if (y < 0 || x < 0 || y >= height || x >= width)
      raise IndexError
    end
    @grid[y][x] = value
  end

  def get(x, y)
    if (y < 0 || x < 0 || y >= height || x >= width)
      raise IndexError
    end
    @grid[y][x]
  end
end

def labyrinth?(path, width, height)
  pairs = path.zip(path[1..path.size])
  pairs.pop
  touching = pairs.map do | first, second |
    x1, y1 = first
    x2, y2 = second
    (x1 - x2).abs + (y1 - y2).abs == 1
  end
  bounded = path.map do | x, y |
    x < width && y < height
  end
  begins_at_top_left = path.first == [0, 0]
  ends_at_bottom_right = path.last == [width-1, height-1]
  right_length = (path.size == width * height) 
  unique = (path.size == path.uniq.size)
  begins_at_top_left && ends_at_bottom_right && right_length && unique && touching.all? && bounded.all?
end

width = 3
height = 5
path = []
(0...width).map do |x|
  (0...height).map do |y|
    path.push([x, y])
  end
end

first = path.shift
last = path.pop

path.permutation.map do |perm|
  attempt = [first] + perm + [last] 
  if labyrinth? attempt, width, height
    puts attempt.inspect
  end
end

