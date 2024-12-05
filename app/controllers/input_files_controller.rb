class InputFilesController < ApplicationController
  def new
  end

  def create
    if params[:file].present?
      # Salva il file con ActiveStorage
      file = params[:file]
      if validate_file(file)
        uploaded_file = ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
        redirect_to matrix_path(blob_id: uploaded_file.id), notice: "File caricato con successo."
      else
        redirect_to new_input_file_path, alert: "Formato file non valido."
      end
    else
      redirect_to new_input_file_path, alert: "Nessun file selezionato."
    end
  end

  private

  def validate_file(file)
    file.content_type == "text/plain"
  end
end
