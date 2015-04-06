require 'protobuf'
require 'google/transit/gtfs-realtime.pb'

class GtrfsManager
  attr_reader :data, :feed_url

  def initialize(feed_url)
    @feed_url = feed_url
    @data = read_data
  end

  def all_positions
    feed.entity.map{|e| e.vehicle}
  end

  def route_positions(route)
    feed.entity.select{|e| e.vehicle.trip.route_id == route }.map{|e| e.vehicle}
  end

  def feed
    Transit_realtime::FeedMessage.decode(data)
  end

  def read_data
    Rails.cache.fetch("position_cache", expires_in: 1.minute) do
      Net::HTTP.get(URI.parse(@feed_url))
    end
  end


  #TODO Pass data path and refresh
  def refresh
    @data = read_data
  end
end
