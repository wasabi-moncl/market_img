#encoding: utf-8

class TemplatesController < ApplicationController
  before_filter :require_login, :right_user
  
  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @templates }
    end
  end
  

  # GET /templates/1
  # GET /templates/1.json
  def show
    @template = Template.find(params[:id])
    
    unless @template.items.empty?
      @template.label_columns.each do |column|
        if @template.labels.find_all_by_column(column).empty?
          label = @template.labels.build({ :column => column.to_s, :size => "12"})
        end
      end
    end
    @photos = @template.photos
    @labels = @template.labels
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @template }
    end
  end

  def composed_image
    template = Template.find(params[:id])
    dst_image = template.photos.find_by_part(params[:part])
    example_item = template.items.last
    dst = Magick::Image.read(dst_image.photo_file.path).first    
    template.labels.find_all_by_part(params[:part]).each do |part_label|
      unless example_item[part_label.column.to_sym].nil?
        begin
          case part_label.gravity.capitalize
          when "North"
            gravity = "North"  
          when "Northeast"
            gravity = "NorthEast"
          when "Northwest"
            gravity = "NorthWest"
          else
            gravity = part_label.gravity.capitalize
          end
          gravity = ("Magick::" + gravity + "Gravity").constantize
        rescue
          gravity = Magick::NorthGravity
        end
        label = Magick::Draw.new
        label.annotate(dst, 0, 0, part_label.x_pos, part_label.y_pos, example_item.send(part_label.column)) do  
          label.fill      = part_label.color
          label.pointsize = part_label.size.to_i
          label.gravity = gravity
          label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
        end
      end
    end
    
    send_data dst.to_blob, :filename => "template_" + template.name + "_" + dst_image.part.to_s + ".png",
          :disposition => 'inline', :type => "image/png"
  end

  # GET /templates/new
  # GET /templates/new.json
  def new
    @template = Template.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @template }
    end
  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
    @photos = @template.photos
    @labels = @template.labels
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(params[:template])

    respond_to do |format|
      if @template.save
        if request.referer == template_molds_path(@template)
          format.html { redirect_to template_molds_path(@template), notice: 'Template was successfully created.' }
        else
          format.html { redirect_to @template, notice: 'Template was successfully created.' }
          format.json { render json: @template, status: :created, location: @template }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /templates/1
  # PUT /templates/1.json
  def update
    template = Template.find(params[:id])
    respond_to do |format|
      if template.update_attributes(params[:template])
        if request.referer == template_molds_url(template)
          format.html { redirect_to template_molds_path(template), notice: '이미지 틀 수정 반영됨.' }
        elsif request.referer == template_elements_url(template)
          format.html { redirect_to template_elements_path(template), notice: '템플릿 구성 부품 수정 반영됨.' }
        else
          format.html { redirect_to template, notice: '반영됨.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template = Template.find(params[:id])
    @template.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end
end
private 

def right_user
  unless current_user.username == "admin" || current_user.username == "moncl" 
    redirect_to root_path
  end
end
