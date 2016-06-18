require 'sinatra'
require 'net/http'
require 'json'

class GbifClient
  def get_occurrences(species_name)
    begin
      JSON.parse(
        make_search_request(species_name)
      )['results']
    rescue
      []
    end
  end

  private

  def make_search_request(species_name)
    Net::HTTP.get(base_url, search_path(species_name))
  end

  def base_url
    'api.gbif.org'
  end

  def search_path(search_term)
    '/v1/occurrence/search?' +
      URI.encode_www_form('scientificName' => search_term, limit: 50)
  end
end

get '/' do
  erb :index
end

get '/search.json' do
  occurrences = GbifClient.new.get_occurrences(params['species'])
  lat_long_data = occurrences.map do |occurrence|
    {
      species: occurrence['species'],
      latitude: occurrence['decimalLatitude'],
      longitude: occurrence['decimalLongitude']
    }
  end

  lat_long_data.to_json
end
