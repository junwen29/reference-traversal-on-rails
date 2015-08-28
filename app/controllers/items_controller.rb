class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all.order("id ASC")
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @list = @item.list
  end

  # POST /items
  # POST /items.json
  def create
    @item  = Item.create(item_params)
    @items = List.find(item_params[:list_id]).items.order("id ASC")
    @list_id = item_params[:list_id]
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item.update_attributes(item_params)
    @items = List.find(item_params[:list_id]).items.order("id ASC")
    @list_id = @item.list.id
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @list_id = @item.list.id
    @item.destroy
    @items = List.find(@list_id).items.order("id ASC")
  end
  
  def list_items
    @items = Item.where(params[:list_id]).order("id ASC")
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :season, :quantity , :list_id)
    end
end
