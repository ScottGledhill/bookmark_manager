require 'web_helper.rb'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, 1@2.3.com')
    expect(User.first.email).to eq('1@2.3.com')
  end
end
