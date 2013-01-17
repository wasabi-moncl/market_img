#encoding: utf-8
class LabelsController < ApplicationController
  def update_all
    template = Template.find(params[:template_id])
    labels = template.labels.find(params[:labels_ids])
    respond_to do |format|
      if @photos.update_attributes(params[:labels_ids])
        format.html { redirect_to template, notice: '반영됨.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: template.errors, status: :unprocessable_entity }
      end
    end
  end
end
