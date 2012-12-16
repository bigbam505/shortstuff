require 'spec_helper'

describe ShortUrl do
  describe "#save" do
    context 'when there is not an entry with that name' do
      it "returns false" do
        shorturl = ShortUrl.new(name: "myname", url: "myurl").save
        shorturl = ShortUrl.new(name: "myname", url: "http://www.google.com")
        expect(shorturl.save).to be_false
      end
    end

    context 'when there is not an entry with that name' do
      it 'returns true' do
        shorturl = ShortUrl.new(name: "myname", url: "myurl")
        expect(shorturl.save).to be_true
      end
    end

    context 'when a name is not given' do
      it "generates a random name" do
        NameGenerator.stubs(:generate).returns("xxx111")

        short_url = ShortUrl.new(url: "http://www.google.com/")
        short_url.save

        expect(short_url.name).to eq("xxx111")
      end

      context "when the name generator returns a name that already exists" do
        it "asks the generator until it finds on that exist" do
          NameGenerator.stubs(:generate).returns("xxx111").then.returns("aaa111")
          ShortUrl.new(name: "xxx111", url: "http://www.google.com").save
          short_url = ShortUrl.new(url: "http://bing.com")
          short_url.save

          expect(NameGenerator).to have_received(:generate).twice
          expect(short_url.name).to eq('aaa111')
        end
      end
    end

    it "will set the url and name properly" do
      shorturl = ShortUrl.new(name: "myname", url: "myurl")
      expect(shorturl.name).to eq("myname")
      expect(shorturl.url).to eq("myurl")
    end
  end

  describe "#full_url" do
    it "returns the full path to the short url" do
      shorturl = ShortUrl.new(name: 'mypage', url: 'http://www.url.com')
      expect(shorturl.full_url).to eq('http://example.com/mypage')
    end
  end
end
