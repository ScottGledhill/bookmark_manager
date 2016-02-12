require 'web_helper.rb'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, 1@2.3.com')
    expect(User.first.email).to eq('1@2.3.com')
  end


  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'dadadsd') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'requires an email to be entered' do
    expect { sign_up(email: '') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email must not be blank')
  end

  scenario "I can't sign up with an invalid email address" do
    expect { sign_up(email: "1@email") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'can\'t sign up with already registered email' do
    sign_up
    expect { sign_up(email: "1@2.3.com") }.not_to change(User, :count)
    expect(page).to have_content 'Email already in use'
  end
end
