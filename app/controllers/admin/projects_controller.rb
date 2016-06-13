class Admin::ProjectsController < Admin::ApplicationController

  before_action :set_project, only: [:destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:notice] = "Project has not been created."
      render "new"
    end
  end

  def destroy

    if @project.destroy
      flash[:notice] = "Project has been deleted"
      redirect_to projects_path
    else
      flash.now[:alert] = "Project has not been deleted"
      render "edit"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project= Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you have been looking for could not be found"
    redirect_to projects_path
  end
end
