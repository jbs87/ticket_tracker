require "rails_helper"

RSpec.feature "Users can only see appropriate links" do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:project) {FactoryGirl.create(:project)}

  context "anonymous users" do
    scenario "cannot see new project link" do
      visit "/"
      expect(page).to_not have_link("New Project")
    end
  end

  context "regular users" do

    before do
      login_as(user)
    end

    scenario "cannot see new project link" do
      visit "/"
      expect(page).to_not have_link("New Project")
    end

    scenario "cannot see delete project link" do
      assign_role!(user, :viewer, project)

      visit project_path(project)
      expect(page).to_not have_link("Delete Project")
    end
  end

  context "admin users" do

    before do
      login_as(admin)
    end

    scenario "can see new project link" do
      visit "/"
      expect(page).to have_link("New Project")
    end

    scenario "can see delete project link" do
      visit project_path(project)
      expect(page).to have_link("Delete Project")
    end
  end



end