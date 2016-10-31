module Api
  module V1
    class ItemsController < ApplicationController
      before_action :get_bucketlist, except: [:create, :index]
      before_action :set_item, except: [:create, :index]

      def create
        @item = Item.new(item_params)
        get_bucketlist_id
        if @item.save
          render json: @item
        else
          render json: { error: "Item not created try again" }
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
          render json: { error: "Item not updated try again" }
        end
      end

      def destroy
        @item.destroy
        render json: { message: "Item deleted" }
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :done)
      end

      def get_bucketlist_id
        @bucketlist = @current_user.bucketlists.find_by(id: params[:id])
        @item.bucketlist_id = @bucketlist.id if @bucketlist
      end
    end
  end
end
