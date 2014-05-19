require 'spec_helper'

describe Project do
  before do
  	@project = Project.new(name: "Test Project", position: 1)
  end
  subject { @project }
  it { should respond_to :name }
  it { should respond_to :position }

  describe "when name is not present" do
  	before { @project.name = "" }
  	it { should_not be_valid }
  end
end
