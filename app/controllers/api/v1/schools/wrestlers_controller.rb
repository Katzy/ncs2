module Api
  module V1
    module Schools
      class WrestlersController < ApplicationController
        respond_to :json

        def index
          respond_with Season.last.wrestlers.where(school_id: params[:id]).present_all
          # respond_with @school.wrestlers.all.present_all
          # respond_with Wrestler.all.present_all
        end

        def show
          respond_with Wrestler.find(params[:id]).present
        end

        def create
        end

        def update
        end

        def destroy
        end
      end
    end
  end
end