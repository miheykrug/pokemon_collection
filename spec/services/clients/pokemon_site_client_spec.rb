require "rails_helper"

RSpec.describe Clients::PokemonSiteClient do
  describe "#get_show_page" do
    subject(:get_show_page) { described_class.new.get_show_page(page) }

    let(:page) { rand(1..10) }
    let(:response) { instance_double(HTTParty::Response, body: response_body) }
    let(:response_body) { "response_body" }

    before do
      allow(HTTParty).to receive(:get).and_return(response_body)
    end

    it "returns response body", :aggregate_failures do
      expect(get_show_page).to eq(response_body)
      expect(HTTParty).to have_received(:get).with("https://scrapeme.live/shop/page/#{page}")
    end
  end
end
