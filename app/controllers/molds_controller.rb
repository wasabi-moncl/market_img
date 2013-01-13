#encoding: utf-8
class MoldsController < ApplicationController
  # GET /molds
  # GET /molds.json
  def index
    @molds = Mold.all

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
    @mold = Mold.new(params[:mold])

    respond_to do |format|
      if @mold.save
        format.html { redirect_to @mold, notice: 'Mold was successfully created.' }
        format.json { render json: @mold, status: :created, location: @mold }
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
        if request.referer == mold_positions_url(@mold)
          format.html { redirect_to mold_positions_path(@mold), notice: '이미지 좌표 수정 반영됨.' }
        else
          format.html { redirect_to template, notice: '반영됨.' }
          format.json { head :no_content }
        end
        format.html { redirect_to @mold, notice: 'Mold was successfully updated.' }
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