#encoding: utf-8
class PositionsController < ApplicationController
  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @positions }
    end
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position }
    end
  end

  # GET /positions/new
  # GET /positions/new.json
  def new
    @position = Position.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position }
    end
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        format.html { redirect_to @position, notice: 'Position was successfully created.' }
        format.json { render json: @position, status: :created, location: @position }
      else
        format.html { render action: "new" }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.json
  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        if request.referer == position_labels_url(@position)
          format.html { redirect_to position_labels_path(@position), notice: '레이블링 수정 반영됨.' }
        else
          format.html { redirect_to template, notice: '반영됨.' }
          format.json { head :no_content }
        end
        format.html { redirect_to @position, notice: 'Mold was successfully updated.' }
        format.json { head :no_content }
      else
        if request.referer == position_labels_url(@position)
          format.html { redirect_to position_labels_path(@position), alert: "설정 저장 안됨. 확인 필요" }
          puts "@@@@@@@@@@"
          @position.labels.each{|label| label.errors.each{|error| puts error}}
        else
          format.html { redirect_to template }
          format.json { head :no_content }
        end
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url }
      format.json { head :no_content }
    end
  end
end
