require "rails_helper"

RSpec.feature "Users can edit tickets" do
  let(:author) {FactoryGirl.create(:user)}
  let(:project) {FactoryGirl.create(:project)}
  let(:ticket) {FactoryGirl.create(:ticket, project: project, author: author)}

  before do
    visit project_ticket_path(project, ticket)
    click_link("Edit Ticket")
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Michael Schumacher"
    fill_in "Description", with: "Formula one"
    click_button("Update Ticket")

    expect(page).to have_content('Ticket has been updated')

    within("#ticket h2") do
      expect(page).to have_content("Michael Schumacher")
      expect(page).to_not have_content(ticket.name)
    end
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: "a"
    fill_in "Description", with: "a"
    click_button("Update Ticket")

    expect(page).to have_content('Ticket has not been updated')
  end
end