class ListsController < ApplicationController
  before_action :all_lists, only: [:index, :create, :update, :destroy]
  before_action :set_lists, only: [:edit, :update, :destroy]
    respond_to :html, :js
      
    def new
      @list = List.new
      @user = User.find(params[:id])
    end

    def create
      @list  = List.create(list_params)
      @lists = User.find(list_params[:user_id]).lists.order("id ASC")
    end
    
    def destroy
      @list = List.find(params[:id])
      @user_id = @list.user_id
      @list.destroy
      @lists = User.find(@user_id).lists.order("id ASC")
    end
    
    def update
      @list.update_attributes(list_params)
      @lists = User.find(list_params[:user_id]).lists.order("id ASC")
    end

    private

      def all_lists
        @lists = List.all.order("id ASC")
      end
      
      def set_lists
        @list = List.find(params[:id])
        @user = @list.user
      end

      def list_params
        params.require(:list).permit(:description, :name, :user_id)
      end

end