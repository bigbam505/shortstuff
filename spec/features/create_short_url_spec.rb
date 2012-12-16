require 'spec_helper'
feature 'user creates a link' do
  scenario 'with a custom name' do
    visit '/'
    fill_in 'Url', with: 'http://google.com'
    fill_in 'Name', with: 'Search'
    click_button 'Create'

    page.should have_content 'Your url: http://example.com/Search'
  end

  scenario 'url name is already taking' do
    ShortUrl.new(name: "Search",url: "http://bing.com").save

    visit '/'
    fill_in 'Url', with: 'http://google.com'
    fill_in 'Name', with: 'Search'
    click_button 'Create'

    page.should have_content 'Search is already taken'
  end

  scenario 'without a name' do
    visit '/'
    fill_in 'Url', with: 'http://google.com'
    click_button 'Create'

    page.text.should match /Your url: http:\/\/example.com\/\w+/
  end
end

