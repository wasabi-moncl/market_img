# encoding: utf-8

require 'csv'

class BannersController < ApplicationController
  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banners }
    end
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
    @banner = Banner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /banners/new
  # GET /banners/new.json
  def new
    @banner = Banner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /banners/1/edit
  def edit
    @banner = Banner.find(params[:id])
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = Banner.new(params[:banner])

    respond_to do |format|
      if @banner.save
        format.html { redirect_to @banner, notice: 'Banner was successfully created.' }
        format.json { render json: @banner, status: :created, location: @banner }
      else
        format.html { render action: "new" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banners/1
  # PUT /banners/1.json
  def update
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.update_attributes(params[:banner])
        format.html { redirect_to @banner, notice: 'Banner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      format.html { redirect_to banners_url }
      format.json { head :no_content }
    end
  end

  def import
    if request.post? && params[:file].present?
      infile = params[:file].read.force_encoding('UTF-8')
      # infile = File.open(params[:file], "r:utf-8")
      n, errs = 0, []

      CSV.parse(infile) do |row|
        n += 1
        # SKIP: header i.e. first row OR blank row
        # next if n == 1 or row.join.blank?
        # build_from_csv method will map customer attributes & 
        # build new customer record
        # banner = Banner.build_from_csv(row)
        banner = Banner.new
        banner.painting_id  = row[0]
        banner.pos_x        = row[1]
        banner.pos_y        = row[2]
        banner.font_color   = row[3]
        banner.bg_color     = row[4]
        banner.font_size    = row[5]
        banner.content      = row[6]
        # Save upon valid 
        # otherwise collect error records to export
        if banner.valid?
          banner.save
        else
          errs << row
        end
      end
      # Export Error file for later upload upon correction
      if errs.any?
        errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
        errs.insert(0, Banner.csv_header)
        errCSV = CSV.generate do |csv|
          errs.each {|row| csv << row}
        end
        send_data errCSV,
          :type => 'text/csv; charset=utf-8; header=present',
          :disposition => "attachment; filename=#{errFile}.csv"
      else
        flash[:notice] = 'csv import successed.'
        redirect_to banners_url #GET
      end
    end
  end

end
