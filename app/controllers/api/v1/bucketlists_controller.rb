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
          render json: { error: not_created_message }
        end
      end

      def index
        render json: @current_user.bucketlists
      end

      def show
        render json: @bucketlist
      end

      def update
        if @bucketlist.update(bucketlist_params)
          render json: @bucketlist
        else
          render json: { error: not_updated_message }
        end
      end

      def destroy
        @bucketlist.destroy
        render json: { message: delete_message }
      end

      private

      def set_bucketlist
        @bucketlist = @current_user.bucketlists.find(params[:id])
        @bucketlist ||= { error: not_permitted_message, status: 403 }
      end

      def bucketlist_params
        params.require(:bucketlist).permit(:name)
      end
    end
  end
end
