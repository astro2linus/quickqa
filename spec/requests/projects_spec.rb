require 'spec_helper'

describe "Projects" do
  subject { page }
  describe "project list page" do
      before { visit '/projects'}
      it { should have_content "Create Project" }
  end

  describe "project show page" do
  	  project = Project.create(name: "ABC", position: 0)
  	  before { visit project_path project}
  	  it {should have_content project.name}
  end

  describe "project create page" do
  	before do 
  		visit new_project_path 
  		fill_in "Name",	with: "Test Project"
  	end
  	
  	it "should create a new project" do 
  		expect { click_button "Create Project" }.to change(Project, :count).by(1)
  	end
  end

end
