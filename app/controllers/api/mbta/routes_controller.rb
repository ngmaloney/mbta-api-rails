class Api::Mbta::RoutesController < Api::MbtaController
  def show
    render json: manager.routes_for_mode(mode)
  end

  private
  def mode
    @mode ||= params[:mode]
  end
end
