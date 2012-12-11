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
  
  def product_image
    @item = Item.find(params[:id])
    image = @item.compose_resources
    send_data image.to_blob, :filename => "product_" + @item.item_code + ".png",
      :disposition => 'inline', :type => "image/png"
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
