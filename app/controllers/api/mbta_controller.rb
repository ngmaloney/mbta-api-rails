module Api
  class MbtaController < ApplicationController
    before_action :set_cors_headers

    private

    def set_cors_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end


    def manager
      @manager ||= MbtaManager.new(Rails.application.config.mbta_api_key)
    end

    def gtrfs_manager
      @gtrfs_manager ||= GtrfsManager.new(Rails.application.config.gtrfs_data)
    end
  end
end
