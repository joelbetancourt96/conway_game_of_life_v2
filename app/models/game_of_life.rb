class GameOfLife
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def next_generation
    new_grid = @grid.map(&:dup)
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        live_neighbors = neighbors(i, j).count { |ni, nj| @grid[ni][nj] == "*" }
        new_grid[i][j] = if cell == "*" && (live_neighbors < 2 || live_neighbors > 3)
                           "."
        elsif cell == "." && live_neighbors == 3
                           "*"
        else
                           cell
        end
      end
    end
    new_grid
  end

  def parse_filebundkle(blob_id)
    blob = ActiveStorage::Blob.find(blob_id)
    content = blob.download
    lines = content.split("\n")
    generation = lines[0].match(/\d+/)[0].to_i
    grid = lines[2..].map(&:chars)
    [ generation, grid ]
  end


  private

  def neighbors(i, j)
    [
      [ i - 1, j - 1 ], [ i - 1, j ], [ i - 1, j + 1 ],
      [ i, j - 1 ],               [ i, j + 1 ],
      [ i + 1, j - 1 ], [ i + 1, j ], [ i + 1, j + 1 ]
    ].select { |ni, nj| ni.between?(0, @grid.size - 1) && nj.between?(0, @grid[0].size - 1) }
  end
end
