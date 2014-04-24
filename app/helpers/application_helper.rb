module ApplicationHelper
	def parse_features
		io = StringIO.new
		formatter = Gherkin::Formatter::JSONFormatter.new(io)
		parser = Gherkin::Parser::Parser.new(formatter)

		sources = get_project_feature_files # defined in projects_helper.rb
		sources.each do |file_path|
		  parser.parse(IO.read(file_path), file_path, 0)
		end

		formatter.done
		MultiJson.load(io.string)
	end

	def parse_features_by_tag(tag)
		features = parse_features
		features_with_tag = []
		features.each do |f|
			if f["tags"].to_s =~ /"#{tag}"/
				features_with_tag << f
			end
		end
		features.each do |f|
			if f.has_key?("elements")
				f["elements"].each do |fe|
					if fe.has_key?("tags") and (fe["tags"].to_s =~ /"#{tag}"/)
						features_with_tag << f
					end
				end
			end
		end
		features_with_tag.uniq
	end

	def parse_scenarios_by_tag(tag)
		features = parse_features
		scenarios_with_tag = []
		features.each do |f|
			if f.has_key?("elements")
				if f["tags"].to_s =~ /"#{tag}"/
					scenarios_with_tag << f["elements"]
				else
					f["elements"].each do |s|
						if s.has_key?("tags")
							if s["tags"].to_s =~ /"#{tag}"/
								scenarios_with_tag << s
							end
						end
					end
				end
			end
		end
		scenarios_with_tag.flatten.uniq
	end

	def parse_tags(features)
		# when the tag is added to the feature
		tags = []
		features.each do |f|
			if f.has_key?("tags") 
				f["tags"].each do |t|
					tags << t["name"]
				end
			end
		end
		# when the tag is associated with a scenario rather than the feature
		scenario_tags = []
		features.each do |f|
			if f.has_key?("elements")
				f["elements"].each do |fe|
					if fe.has_key?("tags") 
						fe["tags"].map do |t|
							scenario_tags << t["name"]
						end
					end
				end
			end
		end
		[tags.flatten.uniq.sort, scenario_tags.flatten.uniq.sort]
	end

	def nav_link(link_text, link_path)
		case link_text
		when "Features" 
  			class_name = (controller_name == "projects" ? 'active	' : '')
  		when "Reports"
  			class_name = (controller_name == "reports" ? 'active' : '')
  		when "Source Files"
  			class_name = (controller_name == "source_files" ? 'active' : '')
  		when "Settings"
  			class_name = (controller_name == "settings" ? 'active' : '')
  		else
  			class_name = ''
  		end

  		content_tag(:li, :class => class_name) do
    		link_to link_text, link_path
  		end
	end
end
