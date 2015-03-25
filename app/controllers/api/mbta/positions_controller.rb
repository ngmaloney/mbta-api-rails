class Api::Mbta::PositionsController < Api::MbtaController
  before_action :refresh_data

  def index
    render json: gtrfs_manager.all_positions
  end

  def show
    render json: gtrfs_manager.route_positions(route)
  end

  private

  def refresh_data
    gtrfs_manager.refresh if params[:refresh]
  end

  def route
    @route ||= params[:route]
  end
end
