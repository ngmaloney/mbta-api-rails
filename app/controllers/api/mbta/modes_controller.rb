class Api::Mbta::ModesController < Api::MbtaController
  def index
    render json: manager.modes
  end
end
