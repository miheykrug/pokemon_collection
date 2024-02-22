class PokemonFetcher
  PRODUCT_ELEMENTS_CSS = "li.product".freeze

  def call
    puts("Start collecting pokemon!")
    hash = pokemon_collection_hash

    writer.call(hash.values)
  end

  private

  def pokemon_collection_hash(page = 1, pokemon_collection = {})
    response = site_html(page)
    document = parsed_document(response)
    product_elements = find_product_elements(document)

    extend_pokemon_collection(product_elements, pokemon_collection)

    next_links = document.css("a.next.page-numbers")

    puts("Page #{page} is collected")

    return pokemon_collection if next_links.blank?

    pokemon_collection_hash(page + 1, pokemon_collection)
  end

  def extend_pokemon_collection(product_elements, pokemon_collection)
    product_elements.each do |product_element|
      pokemon_attributes = pokemon_data(product_element)

      pokemon_product = Pokemon.new(**pokemon_attributes)
      pokemon_collection[pokemon_attributes[:name]] = pokemon_product
    end
  end

  def find_product_elements(document)
    document.css(PRODUCT_ELEMENTS_CSS)
  end

  def pokemon_data(product_element)
    pokemon_data_parser.call(product_element)
  end

  def site_html(page)
    site_client.get_show_page(page)
  end

  def parsed_document(response)
    Nokogiri::HTML(response.body)
  end

  def site_client
    @site_client ||= Clients::PokemonSiteClient.new
  end

  def writer
    Writers::Json.new("result")
  end

  def pokemon_data_parser
    @pokemon_data_parser ||= Parsers::PokemonData.new
  end
end
