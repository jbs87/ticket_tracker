require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  it "handles a missing project correctly" do
    get :show, id: "not-here"

    expect(response).to redirect_to(projects_path)

    message = "The project you have been looking for could not be found"
    expect(flash[:alert]).to eq(message)
  end

  it "handles permission errors be redirecting to a safe place" do
    allow(controller).to receive(:current_user)

    project = FactoryGirl.create(:project)
    get :show, id: project

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that"
    expect(flash[:alert]).to eq message
  end
end
