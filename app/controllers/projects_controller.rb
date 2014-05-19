class ProjectsController < ApplicationController

	include ApplicationHelper
	include ProjectsHelper

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
		@features = parse_features
		all_tags = parse_tags(@features)
		@tags = all_tags[0]
		@scenario_tags = all_tags[1]
	end

	def new
		@project = Project.new
	end

	def edit
		@project = Project.find(params[:id])
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to @project
		else
			render 'new'
		end
	end

	def update
	  	@project = Project.find(params[:id])
	  	if @project.update_attributes(project_params)
	  		redirect_to projects_path
	  	end
	end

	def destroy
		@project = Project.find(params[:id])
  		@project.destroy
  		redirect_to projects_path
	end

	def filter_by_tag
		@project = Project.find(params[:id])
		all_features = parse_features
		all_tags = parse_tags(all_features)
		@tags = all_tags[0]
		@scenario_tags = all_tags[1]
		@selected_tag = params[:tag]
		@scenarios = parse_scenarios_by_tag(params[:tag])
	end

	def start_test_by_tag
		@project = Project.find(params[:project_id])
		title = "no title"
		tag_option = ""
		if params[:selected_tag].nil?
			title = "All scenarios"
		else
			tag_option = "--tags #{params[:selected_tag]} "
			title = tag_option.to_s
		end

		#tag_option = params[:selected_tag].nil? ? "" : "--tags #{params[:selected_tag]} "
		project_root_path, json_report_path, device_target = runtime_option(@project)
		cmd = "cd #{project_root_path} && cucumber #{tag_option} -f json -o #{json_report_path}"

		@project.run_test(title, cmd)
		render :nothing => true
	end

	def start_test
		@project = Project.find(params[:project_id])
		scenario_names = params[:scenario_names]
		scenario_option = ""
		scenario_names.each do |s|
			scenario_option += " -n "
			scenario_option+= "'#{s}'"
		end

		project_root_path, json_report_path, device_target = runtime_option(@project)
		cmd = "cd #{project_root_path} && cucumber #{scenario_option} -f json -o #{json_report_path}"
		title = "Scenarios: " + scenario_names.join("; ")
		@project.run_test(title, cmd)

		render :nothing => true
	end

	private

	def runtime_option(project)
	  project_root_path = get_project_root_path(project)
	  json_report_path = Rails.root.join('tmp/test.json')
	  device_target="DEVICE_TARGET='iPad Retina - Simulator - iOS 7.0'"
	  return project_root_path, json_report_path, device_target
	end

	def project_params
    	params.require(:project).permit(:name)
  	end
end
