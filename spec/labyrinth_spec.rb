require_relative '../src/labyrinth'

describe Grid do
  it 'has width and height' do
    grid = Grid.new(20, 10)
    expect(grid.width).to eq(20)
    expect(grid.height).to eq(10)
  end

  it 'can set value at x, y' do
    grid = Grid.new(20, 10)
    grid.set(4, 8, :foo)
    expect(grid.get(4, 8)).to eq(:foo)
  end

  it 'throws error when out of bounds' do
    grid = Grid.new(20, 10)
    expect { grid.set(4, 10, :foo) }.to raise_error(IndexError)
  end
end

describe 'labyrinth?' do
  it 'returns true' do
    input = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 0], [2, 1]]
    expect(labyrinth?(input, 3, 2)).to be(true)
  end

  it 'has a continuous path' do
    input = [[0, 0], [0, 2], [0, 1]]
    expect(labyrinth?(input, 1, 3)).to be(false)
  end

  it 'has path in bounds' do
    input = [[0, 0], [0, 1], [1, 1]]
    expect(labyrinth?(input, 1, 3)).to be(false)
  end

  it 'covers all spaces' do
    input = [[0, 0], [0, 1]]
    expect(labyrinth?(input, 1, 3)).to be(false)
  end

  it 'covers each square once' do
    input = [[0, 0], [0, 1], [0, 0]]
    expect(labyrinth?(input, 1, 3)).to be(false)
  end

  it 'should begin on [0, 0]' do
    input = [[0, 2], [0, 1], [0, 0]]
    expect(labyrinth?(input, 1, 3)).to be(false)
  end

  it 'should end on [width-1, height-2]' do
    input = [[0, 0], [1, 0], [1, 1], [0, 1]]
    expect(labyrinth?(input, 2, 2)).to be(false)
  end
end
