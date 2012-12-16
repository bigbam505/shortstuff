require 'spec_helper'
feature 'user creates a link' do
  scenario 'with a custom name' do
    visit '/'
    fill_in 'URL', with: 'http://google.com'
    fill_in 'Name', with: 'search'
    click_button 'Submit'
    page.should have_content 'Your url: http://example.com/search'
  end
end
