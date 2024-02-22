# frozen_string_literal: true

namespace :pokemon do
  desc "Collect all pokemon"
  task collect: :environment do
    PokemonFetcher.new.call
  end
end
