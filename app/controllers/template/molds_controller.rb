class Template::MoldsController < ApplicationController
  before_filter :the_template
  
  # GET /molds
  # GET /molds.json
  def index
    @molds = @template.molds
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @molds }
    end
  end

  # GET /molds/1
  # GET /molds/1.json
  def show
    @mold = Mold.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mold }
    end
  end

  # GET /molds/new
  # GET /molds/new.json
  def new
    @mold = Mold.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mold }
    end
  end

  # GET /molds/1/edit
  def edit
    @mold = Mold.find(params[:id])
  end

  # POST /molds
  # POST /molds.json
  def create
    @template_molds = Template.find(params[:id])
    @mold = @template.molds.new(params[:mold])

    respond_to do |format|
      if @template.save
        format.html { redirect_to template_molds_path(@template), notice: 'Mold was successfully created.' }
        format.json { render json: template_mold_path(@template, @mold), status: :created, location: @mold }
      else
        format.html { render action: "new" }
        format.json { render json: @mold.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /molds/1
  # PUT /molds/1.json
  def update
    @mold = Mold.find(params[:id])

    respond_to do |format|
      if @mold.update_attributes(params[:mold])
        format.html { redirect_to template_mold_path(@template, @mold), notice: 'Mold was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mold.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /molds/1
  # DELETE /molds/1.json
  def destroy
    @mold = Mold.find(params[:id])
    @mold.destroy

    respond_to do |format|
      format.html { redirect_to molds_url }
      format.json { head :no_content }
    end
  end
end
private 

def the_template
  @template = Template.find(params[:template_id])
end
