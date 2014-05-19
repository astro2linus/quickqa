class Project < ActiveRecord::Base
	validates :name, presence: true
	has_many :reports
  has_many :settings
	has_many :source_files

  def run_test_old(title, cmd)
    puts cmd
    result = `#{cmd}`
    new_report = self.reports.create(:title => title, :content => result)
  end

  def run_test(title, cmd) 
    puts cmd
    path = Rails.root.join("tmp/test.json")
    system("rm -f #{path}")
    system(cmd)
    result = "[{}]"
    File.open( path, 'r' ) do |out|
        result = out.read.to_s
    end
    report = self.reports.create(:title => title, :content => result)
    ReportMailer.report_email(report).deliver
  end

	def create_source_files_tree
		#delete existing source file tree nodes
    	self.source_files.delete_all
    	#root = self.setting.path
      project_repo_name = self.name.downcase.gsub(' ', '_')
      # by default QuickQA will load features in  scripts_repo/project_name
      source_root_folder = Rails.root.to_s + "/scripts_repo/#{project_repo_name}/features"
      # project root path setting will overwrite default path
      setting = self.settings.first
      source_root_folder  = (self.settings.first.project_root_path.to_s + "/features") unless setting.nil?  
    	traverse_source_files_dir(source_root_folder, nil)
	end

	def traverse_source_files_dir(path, parent)
		puts "path -> " + path
		# list all the files that should not display
		# ignore_list = [".DS_Store"]
    begin
    	if File.directory?(path)
      		dir_name = path.split("\/").last
      		subtree = self.source_files.create(:file_path => path, :file_name => dir_name, :content => "", :project_id => self.id, :parent_id => parent, :node_type => 'dir' )
      		Dir.foreach(path) do |file|
        		if file =="." or file == ".."
          			self.source_files.create(:file_path => path + "/" + file, :file_name => file, :content => "", :project_id => self.id, :parent_id => subtree, :node_type => 'ignore' )
        		else
          			file_name = path.split("\/").last
          			traverse_source_files_dir(path + "/" + file, subtree)
        		end
      		end
    	else
      		file_name = path.split("\/").last
      		unless file_name == ".DS_Store"
        		code = "" # read source file
        		File.open( path, 'r' ) do |out|
          			code = out.read.to_s.strip
        		end
        		self.source_files.create(:file_path => path, :file_name => file_name, :content => code, :project_id => self.id, :parent_id => parent, :node_type => 'file' )
      		end
    	end
    rescue => e
      logger.warn "Unable to find the source files folder: #{e}" 
    end

  end

end
