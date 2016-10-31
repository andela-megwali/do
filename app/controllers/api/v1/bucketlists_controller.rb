module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :get_user_bucketlists, except: [:create]
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
        render json: @bucketlists.search(params[:q]).
          paginate(params[:limit], params[:page])
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

      def get_user_bucketlists
        @bucketlists = @current_user.bucketlists
      end

      def set_bucketlist
        @bucketlist = @bucketlists.find(params[:id])
        return { error: not_permitted_message, status: 403 } unless @bucketlist
      end

      def bucketlist_params
        params.require(:bucketlist).permit(:name)
      end
    end
  end
end
