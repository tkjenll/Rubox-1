class ProjectsController < ApplicationController
  def index
    user = current_user
    puts user.name
    @pers = Permission.where("user_id = " + user.id.to_s)
    @param = params

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pers }
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
    user = current_user
    puts user.name

    @project = Project.new(params[:project])
    userid = user.id.to_i
    puts

    @per = Permission.new
    @per.user_id = userid
    @per.type_id = 1

    
    respond_to do |format|
      if @project.save
        #asigno el id del proyecto al permiso de acceso
        @per.project_id = @project.id
        if @per.save
          #si se guardo en la base de datos, creo el repositorio en el disco
         
		  #Git.init("/var/cache/git/" + @project.name)
		  system('git init --bare /var/cache/git/'+@project.name+'.git') #la libreria no permite crear un repositorio bare

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
    @users = User.where("id <> " + user.id.to_s)
    @pers = Permission.where("project_id = " + params[:id].to_s + " and user_id = " + user.id.to_s).first
    @types = Type.where("id > " + @pers.type_id.to_s)
    @permissions = Permission.where("project_id = " + params[:id].to_s)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  
end
