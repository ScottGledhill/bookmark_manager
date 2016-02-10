require './app/app'
feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'name', with: 'Makers Academy'
    fill_in 'tags',  with: 'education'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'I can add multiple tags' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'name', with: 'Makers Academy'
    fill_in 'tags',  with: 'education shit'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'shit')
    end
  end
