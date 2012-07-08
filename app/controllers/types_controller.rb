class TypesController < ApplicationController
  def index
    @tipos = Type.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipos }
    end
  end
end