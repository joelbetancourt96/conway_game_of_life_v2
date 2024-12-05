class MatrixController < ApplicationController
  def show
    @grid = Array.new(4) { Array.new(8, ".") } # Griglia 4x8 vuota
    @generation = 1
  end

  def start
    grid = Array.new(4) { Array.new(8, ".") } # Carica la griglia iniziale (esempio)
    CalculateGenerationJob.perform_later(grid, 1) # Avvia la simulazione
    head :ok
  end
end
