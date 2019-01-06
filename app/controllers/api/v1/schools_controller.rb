module Api
  module V1
    class SchoolsController < ApplicationController
      before_action -> { doorkeeper_authorize! :public }, only: :index
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :admin, :write
      end
      respond_to :json

      # def show
      #   user = User.find(doorkeeper_token.resource_owner_id)
      #   respond_with Season.last.wrestlers.where(school_id: user.school_id).present_all
      # end

      def show
        respond_with Season.last.wrestlers.where(school_id: params[:id]).present_all
        # respond_with Wrestler.find(params[:id]).present
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