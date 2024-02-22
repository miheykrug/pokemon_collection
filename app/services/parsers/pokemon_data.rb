class Parsers::PokemonData
  def call(product_element)
    {
      id: product_element.css("[data-product_sku]").first["data-product_id"],
      name: product_element.css("h2").first.text,
      price: product_element.css("span").first.text,
      sku: product_element.css("[data-product_sku]").first["data-product_sku"],
      image_url: product_element.css("img").first["src"]
    }
  end
end
