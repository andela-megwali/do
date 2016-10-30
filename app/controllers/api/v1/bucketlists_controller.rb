module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_bucketlist, except: [:create, :index]

      def create
        @bucketlist = Bucketlist.new(bucketlist_params)
        @bucketlist.user_id = @current_user.id
        if @bucketlist.save
          render json: @bucketlist
        else
          render json: { error: "Bucketlist not created try again" }
        end
      end

      def index
        @bucketlists = Bucketlist.all
        render json: @bucketlists
      end

      def show
        render json: @bucketlist
      end

      def update
        if @bucketlist.update(bucketlist_params)
          render json: @bucketlist
        else
          render json: { error: "Bucketlist not updated try again" }
        end
      end

      def destroy
        @bucketlist.destroy
        render json: { message: "Bucketlist deleted" }
      end

      private

      def set_bucketlist
        @bucketlist = Bucketlist.find(params[:id])
      end

      def bucketlist_params
        params.require(:bucketlist).permit(:name)
      end
    end
  end
end
