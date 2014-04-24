class SettingsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @settings = @project.settings
  end

  def new
    @project = Project.find(params[:project_id])
    @setting = @project.settings.build
  end

  def create
    @setting = Setting.new(setting_params)
    if @setting.save
      redirect_to project_settings_path(@setting.project)
    else
      render nothing: true
    end
  end

  def edit
    @setting = Setting.find(params[:id]) 
    @project = @setting.project
  end

  def update
    @project = Project.find(setting_params[:project_id])
    @setting = Setting.find(params[:id]) 
    if @setting.update_attributes(setting_params)
      redirect_to project_settings_path(@project)
    end
  end

  def show
  end

  def destroy
    @setting = Setting.find(params[:id])
    @project = @setting.project
    @setting.destroy
    redirect_to project_settings_path(@project)
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :project_root_path, :project_id, :enabled)
  end
end
