#encoding: utf-8
class User::ItemsController < ApplicationController
  def show
  end
  
  def test_page
    @user = User.where(:username => params[:username]).first
    @template = Template.find(params[:template_id])
    @item = Photo.where(:item_code => params[:item_code]).first.item if Photo.where(:item_code => params[:item_code]).any?
    html_code = @template.code || "<%= @item.name %><%= @brand.name%>"
    render :layout => false
  end
  
  def html_code
    @user = User.where(:username => params[:username]).first
    @template = @user.templates.last
    @item = @user.items.where(:item_code => params[:item_code]).first if @user.items.where(:item_code => params[:item_code]).any?
    html_code = @template.code || "<%= @item.name %><%= @brand.name%>"
    render :layout => false, :inline => @template.code
  end

  def index
    @items = current_user.items.order("created_at desc")
    if current_user.brand.nil?
      redirect_to edit_user_path(current_user), notice: '사용자 정보 수정페이지입니다. 브랜드를 선택해주세요.'
    elsif current_user.items.empty?
      redirect_to first_user_items_path, notice: '1번 단계로 되돌아왔습니다. 먼저, 엑셀 파일을 업로드해주세요.'
    elsif current_user.photos.empty?
      redirect_to new_user_photo_path, notice: '2번 단계로 되돌아왔습니다. 먼저, 상품 사진을 업로드해주세요.'
    elsif current_user.brand.templates.empty?
      redirect_to dashboard_path, notice: '템플릿이 만들어지지 않았습니다. 담당 직원에게 연락주세요.'
    else
      respond_to do |format|
        format.html
        format.csv { send_data @item.to_csv }
        # format.xls
      end
    end
  end
  

  def saved_image
    @user = User.where(:username => params[:username]).first
    @template = @user.templates.last
    @item = @user.items.where(:item_code => params[:item_code]).first if @user.items.where(:item_code => params[:item_code]).any?
    html_code = @template.code || "<%= @item.name %><%= @brand.name%>"
    render :layout => false, :inline => @template.code
  end
  
  def first
    
  end

  def import
    Item.import(params[:file], current_user)
    unless current_user.brand.templates.empty?
      Item.association_to_the_template(current_user)
      redirect_to new_user_photo_path, notice: '상품 정보가 입력되었습니다.'
    else
      redirect_to dashboard_path, notice: '템플릿이 아직 준비되지 않았습니다. 관리자에게 연락 바랍니다.'
    end
  end
  
  def edit
    @item = current_user.items.find(params[:id])
  end

  def destroy
  end

  def update
  end

  def create
  end
end
