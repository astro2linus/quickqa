module ReportsHelper
	def parse_report_json(json_str)
		data = '<table class="table table-condensed">'
		jo = MultiJson.load(json_str)
		one_feature_html(jo, data)
		data << '</table>'
		puts data
		data.html_safe
	end

	# data is used to store one feature's html
	# data = ''
	# one_feature_html(MultiJson.load(io.string), data)
	# data.html_safe
	# return html source code for one feature file
	def one_feature_html(o, data)
		if o.class == Array
			o.each do |m|
				one_feature_html(m, data)
			end
		elsif o.class == Hash
			o.keys.each do |k|
				case k
				when "keyword"
					if o[k] == "Feature" 
						data << '<tr class="active"><td>' << '<span class="key-word">Feature: </span>'
					elsif o[k] == "Scenario"
						data << '<tr class="alert-info"><td>' << '<span class="key-word">Scenario: </span>'
					elsif o[k] == "Scenario Outline"
						data << '<tr class="alert-info"><td>' << '<span class="key-word">Scenario Outline: </span>'
					elsif o[k] == "Given " || o[k] == "And " || o[k] == "Then " || "When "
						# Steps for Scenario Outline donot have "result"
						if o["result"].nil?
							break
						end
						
						if o["result"]["status"] == "undefined"
							data << '<tr class="warning"><td>'
						elsif o["result"]["status"] == "passed"
							data << '<tr class="success"><td>'
						elsif o["result"]["status"] == "failed"
							data << '<tr class="danger"><td>'
						elsif o["result"]["status"] == "skipped"
							data << '<tr><td>'
						else
							data << '<tr><td>'
						end
						data << '<span class="key-word">'<< o[k] << '</span>'
					end
				when "tags"
				when "name"
					if o[k][0] != "@"
						data <<  " " << o[k] << "</td></tr>"
					end
				when "result","steps", "status", "match","duration", "location" ,"line", "id", "uri", "elements", "path", "description", "type", "comments", "value"
				when "arguments", "offset", "val"
				when "cells", "rows", "examples"
				when "error_message"
						data << '<tr class="danger"><td>' << o[k] << "</td></tr>"
				else
					data << k
				end
				one_feature_html o[k], data
			end
			data << '</tr>'
		end	
	end
end
