class ProjectsController < ApplicationController
  def index
    user = current_user
    puts user.name
    @Projects = Project.joins(:users).where("users.id = " + user.id.to_s)
    @param = params

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Projects }
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def create
    #muestra los parametros en la consola del server
    puts params

    @project = Project.new(params[:project])
    path = params[:path]
    userid = params[:user_id].to_i
    

    @per = Permission.new(:path => path)
    @per.user_id = userid
    @per.type_id = 1

    
    respond_to do |format|
      if @project.save
        #asigno el id del proyecto al permiso de acceso
        @per.project_id = @project.id
        if @per.save
          #si se guardo en la base de datos, creo el repositorio en el disco
          Git.init("/var/cache/git/" + @project.name)

          format.html { redirect_to @project, notice: 'Proyecto creado correctamente' }
          format.json { render json: @project, status: :created, location: @project }
        else
          format.html { render action: "new" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def show
    user = current_user
    puts user.name
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  
end