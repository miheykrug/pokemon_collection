class Clients::PokemonSiteClient
  SITE_URL = "https://scrapeme.live/shop"

  def get_show_page(page)
    HTTParty.get("#{SITE_URL}/page/#{page}")
  end
end
