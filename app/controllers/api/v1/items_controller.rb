module Api
  module V1
    class ItemsController < ApplicationController
      before_action :get_bucketlist_items
      before_action :set_item, except: [:create, :index]
      before_action :prevent_forbidden_item, except: [:create, :index]

      def create
        @item = Item.new(item_params)
        set_bucketlist_id
        if @item.save
          render json: @item
        else
          render json: { error: not_created_message }, status: 400
        end
      end

      def index
        return forbidden_message unless @items
        render json: @items.paginate(params[:limit], params[:page])
      end

      def show
        render json: @item
      end

      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: { error: not_updated_message }, status: 400
        end
      end

      def destroy
        render json: { message: delete_message } if @item.destroy
      end

      private

      def item_params
        params.permit(:name, :done)
      end

      def get_bucketlist_items
        @bucketlist = @current_user.bucketlists.
                      find_by(id: params[:bucketlist_id])
        @items = @bucketlist.items if @bucketlist
      end

      def set_item
        @item = @items.find_by(id: params[:id]) if @items
      end

      def prevent_forbidden_item
        return forbidden_message unless @item
      end

      def set_bucketlist_id
        @item.bucketlist_id = @bucketlist.id
      end
    end
  end
end
