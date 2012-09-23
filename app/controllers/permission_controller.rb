class PermissionController < ApplicationController
  def index
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def create
    
  end
end
