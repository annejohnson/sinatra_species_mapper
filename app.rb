require 'sinatra'
require 'net/http'
require 'json'

class GbifClient
  def get_occurrences(species_name)
    begin
      JSON.parse(
        Net::HTTP.get(base_url, search_path(species_name))
      )['results']
    rescue
      []
    end
  end

  private

  def base_url
    'api.gbif.org'
  end

  def search_path(search_term)
    '/v1/occurrence/search?' +
      URI.encode_www_form('scientificName' => search_term)
  end
end

get '/' do
  erb :index
end

get '/search.json' do
  data = GbifClient.new.get_occurrences(params['species']).map do |occurrence|
    {
      species: occurrence['species'],
      latitude: occurrence['decimalLatitude'],
      longitude: occurrence['decimalLongitude']
    }
  end

  data.to_json
end