class User::ItemsController < ApplicationController
  def show
  end

  def index
    @items = Item.order(:item_code)
    respond_to do |format|
      format.html
      format.csv { send_data @item.to_csv }
      # format.xls
    end
  end

  def import
    Item.import(params[:file])
    Item.association_to_the_template
    redirect_to user_items_path
  end
  
  def edit
  end

  def destroy
  end

  def update
  end

  def create
  end
end
