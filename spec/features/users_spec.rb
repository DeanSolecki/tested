require 'rails_helper'

feature 'User management', js: true do
  scenario 'adds a new user' do
    admin = create(:admin)
    sign_in admin

    visit root_path
    expect{
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@example.com'
      find('#password').fill_in 'Password', with: 'secret123'
      find('#password_confirmation').fill_in 'Password confirmation',
        with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    expect(current_path).to eq users_path
    expect(page).to have_content 'User was successfully created'
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'
  end

  scenario "edit an existing user's email" do
    admin = create(:admin)
    sign_in admin

    user = create(:user)

    visit root_path
    click_link 'Users'
    find(:linkhref, '/users/' + String(user.id) + '/edit').click
    fill_in 'Email', with: 'changed@example.com'
    click_button 'Update User'
    click_link 'Back'
    expect(page).to have_content 'changed@example.com'
  end

  scenario 'delete a user' do
  end

  scenario 'user signs in and out' do
    user = create(:user)

    visit root_path
    expect(page).not_to have_content 'Log Out'

    sign_in user
    expect(page).to have_content 'Log Out'

    sign_out user
    expect(page).not_to have_content 'Log Out'
  end
end
