module Api
  module V1
    class ItemsController < ApplicationController
      before_action :get_bucketlist
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
        @items = Item.all
        render json: @items
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

      def get_bucketlist
        @bucketlist = @current_user.bucketlists.find(params[:bucketlist_id])
      end

      def set_item
        @item = @bucketlist.items.find(params[:id]) if @bucketlist
        @item ||= { error: not_permitted_message, status: 403 }
      end

      def set_bucketlist_id
        @item.bucketlist_id = @bucketlist.id if @bucketlist
      end
    end
  end
end
