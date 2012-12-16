require 'spec_helper'
feature 'user creates a link' do
  scenario 'with a custom name' do
    visit '/'
    fill_in 'Url', with: 'http://google.com'
    fill_in 'Name', with: 'Search'
    click_button 'Create'

    page.should have_content 'Your url: http://example.com/Search'
  end
end
