require "rails_helper"

RSpec.feature do 'Users can view projects'

let(:user) {FactoryGirl.create(:user)}
let(:project) {FactoryGirl.create(:project, name: "BetaMax")}

before do
  login_as(user)
  assign_role!(user, :viewer, project)
end

  scenario 'with the project details' do
    visit "/"
    click_link "BetaMax"
    expect(page.current_url).to eq(project_url(project))
  end

  scenario "unless they do not have permission" do
    FactoryGirl.create(:project, name: "Hidden")
    visit("/")
    expect(page).not_to have_content("Hidden")
  end
end