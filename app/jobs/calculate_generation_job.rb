class CalculateGenerationJob < ApplicationJob
  queue_as :default

  def perform(grid, generation)
    # Calcola la nuova generazione
    new_grid = GameOfLife.next_generation(grid)

    # Invia l'aggiornamento al canale
    ActionCable.server.broadcast("game_channel", {
      grid_html: ApplicationController.render(
        partial: "matrix/grid",
        locals: { grid: new_grid }
      ),
      generation: generation + 1
    })

    # Ricomincia il job se necessario
    CalculateGenerationJob.perform_later(new_grid, generation + 1) if generation < 10
  end
end
