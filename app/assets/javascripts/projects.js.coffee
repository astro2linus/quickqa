# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#start").on 'click', '#start_test',->
		scenario_names = $("input:checkbox:checked").map(-> 
			$(this).prop('checked', this.checked).val()
		).get()
		console.log(scenario_names)
		project_id = $("#project_id").val()

		$.ajax
			url: "/projects/start_test"
			data:
			  {scenario_names: scenario_names, project_id: project_id}
			type: "post"
		return

	$("#start").on 'click', '#start_test_by_tag',->
		selected_tag = $("#selected_tag").val()
		project_id = $("#project_id").val()

		$.ajax
			url: "/projects/start_test_by_tag"
			data:
			  {selected_tag: selected_tag, project_id: project_id}
			type: "post"
		return

	$("#report_list").on 'click', '#select_all_reports', ->
	  checkboxes = $("#report_list").find(":checkbox:enabled")
	  if @checked
	    checkboxes.prop "checked", true
	  else
	    checkboxes.prop "checked", false
	  return

	$("#report_panel").on 'click', '#delete_selected_reports',->
		report_ids = $("input.checkbox-row:checkbox:checked").map(-> 
			$(this).prop('checked', this.checked).val()
		).get()
		console.log(report_ids)

		$.ajax
			url: "/reports/delete_selected_reports"
			data:
			  {report_ids: report_ids}
			type: "post"
		return
