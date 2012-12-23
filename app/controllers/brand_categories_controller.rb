class BrandCategoriesController < ApplicationController
  # GET /brand_categories
  # GET /brand_categories.json
  def index
    @brand_categories = BrandCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brand_categories }
    end
  end

  # GET /brand_categories/1
  # GET /brand_categories/1.json
  def show
    @brand_category = BrandCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand_category }
    end
  end

  # GET /brand_categories/new
  # GET /brand_categories/new.json
  def new
    @brand_category = BrandCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand_category }
    end
  end

  # GET /brand_categories/1/edit
  def edit
    @brand_category = BrandCategory.find(params[:id])
  end

  # POST /brand_categories
  # POST /brand_categories.json
  def create
    @brand_category = BrandCategory.new(params[:brand_category])

    respond_to do |format|
      if @brand_category.save
        format.html { redirect_to @brand_category, notice: 'Brand category was successfully created.' }
        format.json { render json: @brand_category, status: :created, location: @brand_category }
      else
        format.html { render action: "new" }
        format.json { render json: @brand_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brand_categories/1
  # PUT /brand_categories/1.json
  def update
    @brand_category = BrandCategory.find(params[:id])

    respond_to do |format|
      if @brand_category.update_attributes(params[:brand_category])
        format.html { redirect_to @brand_category, notice: 'Brand category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brand_categories/1
  # DELETE /brand_categories/1.json
  def destroy
    @brand_category = BrandCategory.find(params[:id])
    @brand_category.destroy

    respond_to do |format|
      format.html { redirect_to brand_categories_url }
      format.json { head :no_content }
    end
  end
end
