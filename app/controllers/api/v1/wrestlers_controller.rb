module Api
  module V1
    class WrestlersController < ApplicationController
       http_basic_authenticate_with name: "admin", password: "ncsteam"
      respond_to :json

      def index
        respond_with Wrestler.all.present_all
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