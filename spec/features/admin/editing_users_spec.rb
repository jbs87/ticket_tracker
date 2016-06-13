require "rails_helper"

RSpec.feature "Admins can change a users details" do

  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, :admin)}

  before do
    login_as(admin)
    visit admin_user_path(user)
    click_link("Edit User")
  end

  scenario "with valid details" do
    fill_in "Email", with: "change@test.com"
    click_button "Update User"

    expect(page).to have_content("User has been updated")
    expect(page).to have_content("change@test.com")
    expect(page).to_not have_content(user.email)
  end

  scenario "making admin" do
    check "admin"
    click_button "Update User"

    expect(page).to have_content("User has been updated")
    expect(page).to have_content("#{user.email} (Admin)")
  end

end