require "rails_helper"

RSpec.feature "Users can view tickets" do

  let(:author) {FactoryGirl.create(:user)}

  before do
    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    assign_role!(author, :viewer, sublime)
    FactoryGirl.create(:ticket, project: sublime,
    name: "Starburst",
    description: "Sunshine and rainbows",
    author: author)

    ie = FactoryGirl.create(:project, name: "Chrome")
    assign_role!(author, :viewer, ie)

    FactoryGirl.create(:ticket, project: ie,
    name: "Compatibility",
    description: "Windows 7 and rainbows")
    login_as(author)
    visit("/")
  end

  scenario "for a given project" do
    click_link("Sublime Text 3")

    expect(page).to have_content("Starburst")
    expect(page).to_not have_content("Chrome")
    click_link("Starburst")
    within("#ticket h2") do
      expect(page).to have_content "Starburst"
    end

    expect(page).to have_content "Sunshine and rainbows"
  end
end