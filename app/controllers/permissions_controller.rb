class PermissionsController < ApplicationController
  def index
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def create
    
    puts params
    user = current_user
    puts user.name
    @project = Project.find(params[:project_id])
    @pers = Permission.where("project_id = " + params[:project_id].to_s + " and user_id = " + user.id.to_s).first
    if @pers.type.description != "owner"
      redirect_to @project, notice: 'Error, usted no es el dueno'
    else


=begin
/*controla que no este dado el permiso ya*/
=end
      qry = "project_id = " + params[:project_id] +
        " and user_id = " + params[:user_id]
      @pers = Permission.where(qry)
      puts @pers
      if @pers.length > 0
        redirect_to @project, notice: 'Permiso ya otorgado al usuario' + User.find(params[:user_id]).name
      else

        @otorga = Permission.new
        @otorga.project_id = params[:project_id].to_i
        @otorga.type_id = params[:type_id]
        @otorga.user_id = params[:user_id]

        if @otorga.save
          redirect_to @project, notice: 'Permiso otorgado correctamente'
        else
          redirect_to @project, notice: 'Error al otorgar el permiso'
        end
      end
    end
  end

  def destroy
    @pers = Permission.find(params[:id])
    @pers.destroy
    respond_to do |format|
      format.html { redirect_to @pers.project }
      format.json { head :no_content }
    end
  end
end
