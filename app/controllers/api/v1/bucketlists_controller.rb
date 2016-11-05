module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :get_user_bucketlists, except: [:create]
      before_action :set_bucketlist, except: [:create, :index]
      before_action :prevent_forbidden_bucketlist, except: [:create, :index]

      def create
        @bucketlist = Bucketlist.new(bucketlist_params)
        @bucketlist.user_id = @current_user.id
        if @bucketlist.save
          render json: @bucketlist
        else
          render json: { error: not_created_message }, status: 400
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
        return not_updated unless @bucketlist.update(bucketlist_params)
        render json: @bucketlist
      end

      def destroy
        render json: { message: delete_message } if @bucketlist.destroy
      end

      private

      def get_user_bucketlists
        @bucketlists = @current_user.bucketlists
      end

      def set_bucketlist
        @bucketlist = @bucketlists.find_by(id: params[:id])
      end

      def prevent_forbidden_bucketlist
        return not_permitted unless @bucketlist
      end

      def bucketlist_params
        params.permit(:name)
      end
    end
  end
end
