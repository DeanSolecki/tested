module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    expect(page).to have_content 'Logged in!'
  end

  def sign_out(user)
    visit root_path
    click_link 'Log Out'
    expect(page).to have_content 'Logged out!'
  end
end
