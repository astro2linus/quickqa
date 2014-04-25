require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'multi_json'

module ProjectsHelper

	def get_project_feature_files
		project_root_path = get_project_root_path(@project)
		path = "#{project_root_path}/features/**/*.feature"
		files = Dir.glob(path)
		files.uniq
	end

	def get_project_root_path(project)
		# the features folder is expected to be directly in this folder, not in its subfolder		
		if project.settings.where(enabled: true).first.nil?
			project_repo_name = project.name.gsub(' ','_')
			Rails.root.join("scripts_repo/#{project_repo_name}")
		else
			project.settings.where(enabled: true).first.project_root_path
		end
	end
end
