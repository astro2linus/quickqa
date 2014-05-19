class ReportMailer < ActionMailer::Base
	default from: "linus@intridea.com"

	def report_email(report)
		@report = report
		@project = report.project
		mail(to: "astro2linus@gmail.com", subject: "QuickQA Test Report")
	end
end