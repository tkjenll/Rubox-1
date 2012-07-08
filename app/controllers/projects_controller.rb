class ProjectsController < ApplicationController
  def index
    @Projects = Project.all
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
    @project = Project.new(params[:project])     

    respond_to do |format|
      if @project.save
        #si se guardo en la base de datos, creo el repositorio en el disco
        Git.init("/var/cache/git/" + @project.name)
        format.html { redirect_to @project, notice: 'Proyecto creado correctamente' }
        format.json { render json: @project, status: :created, location: @project }
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
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyect }
    end
  end
end