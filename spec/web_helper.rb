def sign_up
  visit '/users/new'
  fill_in :email,    with: '1@2.3.com'
  fill_in :password, with: 'IHATEYOU'
  click_button 'Sign up'
end
