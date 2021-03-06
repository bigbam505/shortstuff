require 'spec_helper'

feature 'redirecting users to short links', js: true do
  scenario 'A valid link is visited' do
    short_url = ShortUrl.new(url: "http://www.google.com", name: "tester")
    short_url.save

    visit "/tester"

    page.should have_content 'Google'
  end

  scenario 'visiting an invalid link' do
    visit '/linkthatdoesnotexist'

    page.should have_content 'This link does not exist.'
  end
end
