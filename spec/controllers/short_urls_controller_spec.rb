require 'spec_helper'

describe ShortUrlsController do
  describe "#post" do
    context 'with a valid short url' do
      it "returns a url" do
        post :create, url: 'http://google.com', name: 'search', format: :json
        json = JSON.parse(response.body)

        expect(json["name"]).to eq("search")
        expect(json["url"]).to eq("http://google.com")
        expect(json["full_url"]).to eq("http://example.com/search")
      end
    end

    context "with an invalid url" do
      it "returns a json error list" do
        post :create, url: 'google.com', format: :json
        json = JSON.parse(response.body)

        expect(response.status).to eq(500)
        expect(json["errors"]).to include("url")
      end
    end
  end
end
