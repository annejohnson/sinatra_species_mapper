require 'sinatra'
require 'net/http'
require 'json'

class GbifClient
  def get_species_names(common_name)
    results = get_results(species_name_path(common_name))
    get_name_data(results)
  end

  def get_species_occurrences(species_name)
    results = get_results(species_occurrences_path(species_name))
    get_occurrence_data(results)
  end

  private

  def get_name_data(results)
    results = results.map do |result|
      {
        species_name: result['species'],
        common_name: get_vernacular_name(result)
      }
    end
    results.select { |result| result[:common_name] }.
            uniq { |result| result[:species_name] }
  end

  def get_vernacular_name(result)
    result['vernacularNames'].select { |h| h['language'] == 'eng' }.
                              map { |h| h['vernacularName'] }.
                              first
  end

  def get_occurrence_data(results)
    results.map do |result|
      {
        species_name: result['species'],
        latitude: result['decimalLatitude'],
        longitude: result['decimalLongitude'],
        common_name: result['vernacularName']
      }
    end.select do |result|
      [:species_name, :latitude, :longitude].all? { |k| result[k] }
    end
  end

  def get_results(path)
    begin
      JSON.parse(
        Net::HTTP.get(base_url, path)
      )['results']
    rescue
      []
    end
  end

  def species_name_path(common_name)
    '/v1/species/search?' +
      URI.encode_www_form(
        q: common_name,
        nameType: 'SCIENTIFIC',
        rank: 'SPECIES',
        status: 'ACCEPTED',
        limit: 50
      )
  end

  def species_occurrences_path(species_name)
    '/v1/occurrence/search?' +
      URI.encode_www_form(
        scientificName: species_name,
        limit: 20
      )
  end

  def base_url
    'api.gbif.org'
  end
end

get '/' do
  erb :index, layout: :main
end

get '/search.json' do
  api_client = GbifClient.new

  species_name = api_client.get_species_names(params['commonName']).first[:species_name]
  lat_long_data = api_client.get_species_occurrences(species_name)

  lat_long_data.to_json
end
