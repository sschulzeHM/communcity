class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add, :remove]
  before_action :authenticate_organisation!, only: [:new, :create]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_organisation.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add

    @project.users << current_user if current_user and @project.joinable? current_user
    respond_to do |format|
      if @project.save
      format.html { redirect_to @project, notice: "Du bist jetzt dabei!"}
      format.json { render :show, status: :created, location: @project}
      else
        format.html { redirect_to @project, alert: "Etwas ist schiefgegangen"}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    @project.users.delete current_user if current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Du bist nicht mehr dabei :("}
        format.json { render :show, status: :created, location: @project}
      else
        format.html { redirect_to @project, alert: "Etwas ist schiefgegangen"}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].permit(:name, :location, :date_from, :date_to, :description, :category, :max_users)
    end
end
