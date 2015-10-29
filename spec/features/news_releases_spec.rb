require 'rails_helper'

feature "News releases" do
  context "as a user" do
    scenario "adds a news release" do
      user = create(:user)
      sign_in(user)
      visit root_path
      click_link "News"

      expect(page).to_not have_content "BigCo switches to Rails"
      click_link "add News Release"

      fill_in "Date", with: "2015-10-29"
      fill_in "Title", with: "BigCo switches to Rails"
      fill_in "Body", with: "BigCo has released a new website built with open source."
      click_button "Create News Release"

      expect(current_path).to eq news_release_path
      expect(page).to have_content "Successfully created news release."
      expect(page).to have_content "2015-10-29: BigCo switches to Rails"
    end
  end

  context "as a guest" do
    scenario "reads a news release"
  end
end
