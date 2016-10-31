module Api
  module V1
    class ItemsController < ApplicationController
      before_action :get_bucketlist_items
      before_action :set_item, except: [:create, :index]

      def create
        @item = Item.new(item_params)
        set_bucketlist_id
        if @item.save
          render json: @item
        else
          render json: { error: not_created_message }
        end
      end

      def index
        render json: @items.paginate(params[:limit], params[:page])
      end

      def show
        render json: @item
      end

      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: { error: not_updated_message }
        end
      end

      def destroy
        @item.destroy
        render json: { message: delete_message }
      end

      private

      def item_params
        params.require(:item).permit(:name, :done)
      end

      def get_bucketlist_items
        @bucketlist = @current_user.bucketlists.find(params[:bucketlist_id])
        return { error: not_permitted_message, status: 403 } unless @bucketlist
        @items = @bucketlist.items
      end

      def set_item
        @item = @items.find(params[:id])
        return { error: not_permitted_message, status: 403 } unless @item
      end

      def set_bucketlist_id
        @item.bucketlist_id = @bucketlist.id
      end
    end
  end
end
