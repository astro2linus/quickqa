module SourceFilesHelper
	def source_files_bread_crumb(node)
      return if node.nil?

    	link = '<li>' + node.file_name + '</li>'
    	until node == node.root      
      		node = node.parent
      		link = "#{link_to node.file_name, node}" + " / " + link
    	end
      link = '<ol class="breadcrumb">' + link + '</ol>'
    	link.html_safe 
  	end 

  def tree_table
    return "<p>Please upload your test scripts</p>".html_safe if @root.nil?

    if @root.node_type == 'file'
       %{#{render 'form'}}.html_safe
    else
      table = %{<table class="table table-hover"><tbody>
        <tr><th></th><th>Name</th><th>Updated at</th></tr>}
        @root.children.each do |node|
          if node.node_type == 'dir'
            table += %{<tr><td>#{image_tag("folder.jpg")}</td>
              <td>#{link_to node.file_name, node}</td>
              <td>#{node.updated_at.to_s[0..9]}</td></tr>}
          elsif node.node_type == 'file'
            table += %{<tr><td>#{image_tag("file.png")}</td>
              <td>#{link_to node.file_name, node}</td>
              <td>#{node.updated_at.to_s[0..9]}</td></tr>}
          end
        end
      table += %{</tbody></table>}
      table.html_safe
    end
  end
end
