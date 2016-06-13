require 'rails_helper'

RSpec.feature "Users can edit existing projects" do

  before do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, name: "Sublime Text 3")
    assign_role!(user, :viewer, project)
    login_as(user)
    visit "/"
    click_link project.name
    click_link "Edit Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Sublime Text 4 Beta"
    click_button "Update Project"
    expect(page).to have_content("Project has been updated")
    expect(page).to have_content("Sublime Text 4 Beta")
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"
    expect(page).to have_content("Project has not been updated")
  end



end