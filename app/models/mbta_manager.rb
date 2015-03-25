class MbtaManager
  attr_reader :api_key

  def initialize(api_key)
    @api_key = api_key
  end

  def modes
    routes.map{ |r| {r["route_type"] => r["mode_name"]} }
  end

  def routes_for_mode(mode)
    routes.select{ |r| r["route_type"] == mode }.first["route"]
  end

  def predictions_for_route(route)
    Rails.cache.fetch("mbta/prediction/#{route}", expires_in: 15.minutes) do
      client.predictions_by_route(route)
    end
  end

  def routes
    Rails.cache.fetch("mbta/routes", expires_in: 30.days) do
      @routes ||= client.routes["mode"]
    end
  end

  private

  def client
    @client ||= Mbta::Client.new(api_key: Rails.application.config.mbta_api_key)
  end
end
