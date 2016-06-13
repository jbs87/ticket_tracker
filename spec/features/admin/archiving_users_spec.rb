require "rails_helper"

RSpec.feature "An admin can archive a user" do

  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, :admin)}

  before do
    login_as(admin)
  end

  scenario "successfully" do
    visit admin_user_path(user)
    click_link("Archive user")

    expect(page).to have_content("User has been archived")
    expect(page).to_not have_content(user.email)
  end

  scenario "cannot archive self" do
    visit admin_user_path(admin)
    click_link("Archive user")

    expect(page).to have_content("You cannot archive yourself")
  end

end